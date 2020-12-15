//
//  NetworkClient.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum Result<T, U: Error> {
    case success(T)
    case failure(U?)
}

protocol NetworkClientProtocol {

    func request(_ url: URL) -> Observable<Data>
}

class NetworkClient: NetworkClientProtocol {
    
    func request(_ url: URL) -> Observable<Data> {
          
        return Observable.create { observer -> Disposable in
            AF.request(url)
                .validate(statusCode: Constants.minStatusSuccess..<Constants.maxStatusSuccess)
                .response { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            NetworkHandlingError().handleError(response, observer)
                            return
                        }
                        observer.onNext(data)
                    case .failure(let error):
                        NetworkHandlingError().handleError(response, observer, error)
                    }
            }
            return Disposables.create()
        }
    }
    
}
