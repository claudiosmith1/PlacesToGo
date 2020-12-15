//
//  NetworkHandlerError.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct NetworkHandlingError<T, U> {
    
    func handleError(_ response: AFDataResponse<T>,
                     _ observer: AnyObserver<U>, _ error: AFError? = nil) {

        switch response.result {
        case .success:
             observer.onError(CustomNetworkError(.invalidData))
        case .failure:
            if let code = response.response?.statusCode, let reason = error?.errorDescription {
                observer.onError(CustomNetworkError(reason, code))
            } else if let code = error?.responseCode, let reason = error?.errorDescription {
                observer.onError(CustomNetworkError(reason, code))
            }
        }
    }

    func handleError(_ observer: AnyObserver<U>, _ error: AFError? = nil) {
        if let code = error?.responseCode, let reason = error?.errorDescription {
            observer.onError(CustomNetworkError(reason, code))
        } else  {
            observer.onError(CustomNetworkError(.invalidData))
        }
    }

}
