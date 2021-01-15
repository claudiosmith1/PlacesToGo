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

        var gnerror: CustomNetworkError!

        switch error?._code {
        case nil:
            gnerror = CustomNetworkError(.invalidData)
            break
        case ErrorKnown.noConnection:
            gnerror = CustomNetworkError(.noInternet)
            break
        default: break
        }

        observer.onError(gnerror)
    }

}
