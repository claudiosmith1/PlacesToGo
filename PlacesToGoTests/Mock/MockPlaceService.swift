//
//  MockPlaceService.swift
//  PlacesToGoTests
//
//  Created by Claudio Smith on 14/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import RxSwift

@testable import PlacesToGo

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

final class MockPlaceService: PlaceServiceProtocol {
    
    var getPlacesResult: Result<[Place], CustomNetworkError>?
    var getPhotoResult: Result<UIImage, CustomNetworkError>?
    
    func fetchPlaces(_ url: URL) -> Observable<[Place]> {
        
        return Observable.create { observer in
            switch self.getPlacesResult {
            case .success(let places)?:
                observer.onNext(places)
            case .failure(let error)?:
                observer.onError(error!)
            case .none:
                observer.onError(CustomNetworkError(.invalidEndpoint))
            }
            return Disposables.create()
        }
    }
    
    func fetchPhoto(_ url: URL) -> Observable<UIImage> {
        
        return Observable.create { observer in
            switch self.getPhotoResult {
            case .success(let image)?:
                observer.onNext(image)
            case .failure(let error)?:
                observer.onError(error!)
            case .none:
                observer.onError(CustomNetworkError(.invalidEndpoint))
            }
            return Disposables.create()
        }
    }
}
