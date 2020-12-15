//
//  PlaceViewModelTest.swift
//  PlacesToGoTests
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import XCTest
import RxSwift
import CoreLocation

@testable import PlacesToGo

class PlaceViewModelTest: XCTestCase {

    func testGetPlacesWithSuccess() {

        let name = "AZ Motorcycle"
        let disposeBag = DisposeBag(),
            service = MockPlaceService()
        service.getPlacesResult = .success(payload: MockPlace.fakePlaces())
        
        let viewModel = PlaceViewModel(service),
            lat = -33.8670522,
            lng = 151.1957362,
            currentLocation = CLLocation(latitude: lat, longitude: lng)
        
        viewModel.fetchPlaces(type: .restaurant, currentLocation: currentLocation)
        
        let expectPlaceCreated = expectation(description: "Places contains AZ Motorcycle")
        var foundPlace = false
        
        viewModel.behavPlaces.subscribe (onNext: { places in
            if places.first(where: {$0.name == name}) != nil {
                foundPlace = true
            }
            XCTAssertTrue(foundPlace)
            expectPlaceCreated.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectPlaceCreated], timeout: 5.0)
    }
    
    func testGetImageWithSuccess() {
        
        let disposeBag = DisposeBag(),
            service = MockPlaceService(),
            mockImage = MockPlace.mockImage()
            service.getPhotoResult = .success(payload: mockImage)
        
        let viewModel = PlaceViewModel(service),
            viewdata = PlaceViewData.mockViewData()
        
        viewModel.fetchPhoto(viewdata: viewdata)
        
        let expectPlaceCreated = expectation(description: "Right fetched photo")
        
        viewModel.observerPhoto.subscribe (onNext: { image in
            XCTAssertEqual(image, mockImage)
            expectPlaceCreated.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectPlaceCreated], timeout: 5.0)
    }
    
    func testGetPlacesWithNotFoundError() {

        let disposeBag = DisposeBag(),
            service = MockPlaceService()
        
        service.getPlacesResult = .failure(CustomNetworkError(.invalidEndpoint))
        
        let viewModel = PlaceViewModel(service),
            lat = -33.8670522,
            lng = 151.1957362,
            currentLocation = CLLocation(latitude: lat, longitude: lng)
        
        viewModel.fetchPlaces(type: .restaurant, currentLocation: currentLocation)
        
        let expectPlaceCreated = expectation(description: "Endpoint not found")
        var notFoundError = false
        
        viewModel.errorTest.subscribe(onNext: {(error) in
                
                if let error = error as? CustomNetworkError,
                   let message = error.errDescription,
                   message == ServiceError.invalidEndpoint.errorMessage {
                   notFoundError = true
                }
                
                XCTAssertTrue(notFoundError)
                expectPlaceCreated.fulfill()

        }).disposed(by: disposeBag)

        wait(for: [expectPlaceCreated], timeout: 5.0)
    }
    
}


