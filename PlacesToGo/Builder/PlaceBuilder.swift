//
//  PlaceBuilder.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 10/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import CoreLocation

protocol PlaceBuilderProtocol {
    mutating func set(model: [Place], currentLocation: CLLocation) -> Self
    var places: [PlaceViewData] { get set }
}

extension PlaceBuilderProtocol {
    
    mutating func set(model: [Place], currentLocation: CLLocation) -> Self {
        setViewData(model, currentLocation)
        return self
    }
    
    mutating func setViewData(_ model: [Place], _ currentLocation: CLLocation) {

        places = [PlaceViewData]()
        model.forEach() { element in

            var rating = Constants.emptyString,
                usersRatingTotal = Constants.emptyString
                
            let name = element.name ?? Constants.emptyString
            let totalStars = element.rating ?? Numbers.zeroDouble
            if let ratin = element.rating {
               rating = String(ratin)
            }
            
            let openNow: PlaceState = (element.hours?.openNow == true ? .open : .closed)
                       
            if let ratings = element.userRatingsTotal {
                usersRatingTotal = "(\(ratings))"
            }
            
            let photo = getPhoto(from: element)
            let viewdata = PlaceViewData(name, photo, rating, openNow,
                                         usersRatingTotal, element.icon, totalStars)
            places.append(viewdata)
        }
    }

    private func getPhoto(from element: Place) -> PhotoViewData? {
        
        var photoViewdata: PhotoViewData?
        if let photos = element.photos, photos.count > Numbers.zeroInt {
           let photo = photos[Numbers.zeroInt]
                       
           if let photoReference = photo.photoReference,
              let height = photo.height, let width = photo.width {
               
              let size = resizeIfNedeed(height, width)
              photoViewdata = PhotoViewData(height: Int(size.height), width: Int(size.width),
                                            photoReference: photoReference)
           }
        }
        return photoViewdata
    }
    
    private func resizeIfNedeed(_ height: Int, _ width: Int) -> CGSize {
        
        var w = CGFloat(width), h = CGFloat(height)
        let maxHeight = UIScreen.main.bounds.height,
            maxWidth = UIScreen.main.bounds.width
        
        if (w > maxWidth) {
            let ratio: CGFloat = h / w
            w = maxWidth
            h = w * ratio
        }
        
        if (h > maxHeight) {
            let ratio: CGFloat = w / h
            h = maxHeight
            w = h * ratio
        }
        return CGSize(width: w, height: h)
    }
    
    func build() -> [PlaceViewData] {
        return places
    }
}

struct PlaceBuilder: PlaceBuilderProtocol {
    var places: [PlaceViewData]
    init() {
        places = [PlaceViewData]()
    }
}

enum Measure: String {
    case km, mt
}
