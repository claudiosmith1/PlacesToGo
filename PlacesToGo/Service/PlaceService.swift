//
//  PlaceService.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol PlaceServiceProtocol {
    func fetchPlaces(_ url: URL) -> Observable<[Place]>
    func fetchPhoto(_ url: URL) -> Observable<UIImage>
}

struct PlaceService: PlaceServiceProtocol {
    
    var cache: NSCache<NSString, UIImage>!
    private let disposeBag = DisposeBag()
    
    init() {
        self.cache = NSCache()
    }
    
    func fetchPlaces(_ url: URL) -> Observable<[Place]> {

        return Observable.create { observer -> Disposable in
            
            NetworkClient().request(url).subscribe( onNext: { data in
                do {
                    let results = try JSONDecoder().decode(Results.self, from: data)
                    guard let place = results.place else {
                        observer.onError(CustomNetworkError(.invalidData))
                        return
                    }
                    observer.onNext(place)
                    observer.onCompleted()
                } catch {
                    print(error)
                    observer.onError(error)
                }
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func fetchPhoto(_ url: URL) -> Observable<UIImage> {
        
        return Observable.create { observer -> Disposable in
            
            if let image = self.cache.object(forKey: url.absoluteString as NSString) {
                observer.onNext(image)
                observer.onCompleted()
                return Disposables.create()
            }
            
            NetworkClient().request(url).subscribe( onNext: { data in
                if let image = UIImage(data: data) {
                   self.cache.setObject(image, forKey: url.absoluteString as NSString)
                   observer.onNext(image)
                   observer.onCompleted()
                } else {
                    observer.onError(CustomNetworkError(.invalidData))
                }
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
