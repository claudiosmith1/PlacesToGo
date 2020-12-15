//
//  PlaceViewModel.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class PlaceViewModel {

    var placeService: PlaceServiceProtocol?
    let error = PublishSubject<Error>()
    let observerPlaces = PublishSubject<[PlaceViewData]>()
    let observerPhoto: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)

    let errorTest = BehaviorRelay<Error?>(value: nil)
    let behavPlaces = BehaviorRelay<[PlaceViewData]>(value: [])
    
    private let disposeBag = DisposeBag()

    init(_ placeService: PlaceServiceProtocol?) {
        self.placeService = placeService
    }

    func fetchPlaces(type: PlaceType, currentLocation: CLLocation) {
        
        var builder: PlaceUrlBuilderProtocol = PlaceUrlBuilder()
        guard let url = builder.set(type: type, currentLocation: currentLocation)
                               .build() else {
            let error = CustomNetworkError(.invalidData)
            self.error.onNext(error)
            return
        }

        placeService?.fetchPlaces(url).subscribe( onNext: { [weak self] place in
            guard let self = self else { return }

            var builder: PlaceBuilderProtocol = PlaceBuilder()
            let places = builder.set(model: place, currentLocation: currentLocation)
                                .build()
            
            self.behavPlaces.accept(places)
            self.observableSort(places, using: .rating)
            }, onError: { [weak self] error in
                self?.errorTest.accept(error)
                self?.error.onNext(error)
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchPhoto(viewdata: PlaceViewData) {
        
        var builder: PlacePhotoUrlBuilderProtocol = PlacePhotoUrlBuilder()
        guard let url = builder.set(viewdata)
                               .build() else {
            let error = CustomNetworkError(.invalidData)
            self.error.onNext(error)
            return
        }
        
        placeService?.fetchPhoto(url).subscribe( onNext: { [weak self] photo in
                self?.observerPhoto.accept(photo)
                }, onError: { [weak self] error in
                    self?.errorTest.accept(error)
                    self?.error.onNext(error)
                }
        ).disposed(by: disposeBag)
    }
   
    func observableSort( _ list: [PlaceViewData], using sortKey: PlaceSort) {
        
        var sortedList: [PlaceViewData]
        switch sortKey {
            case .name: sortedList = list.sorted { $0.name < $1.name }
            case .rating: sortedList = list.sorted { $0.rating > $1.rating }
            case .openNow: sortedList = list.sorted { $0.openNow.text < $1.openNow.text }
        }
        self.observerPlaces.onNext(sortedList)
    }

    func checkIfHasPhoto(viewdata: PlaceViewData) -> Bool {
        guard let photo = viewdata.photo, photo.photoReference != nil else {
              return false
        }
        return true
    }
}
