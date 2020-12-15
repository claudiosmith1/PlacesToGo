//
//  Place.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let place: [Place]?
    enum CodingKeys: String, CodingKey {
        case place = "results"
    }
}

struct Place: Decodable {
    let name: String?
    let photos: [Photo]?
    let hours: Hours?
    let icon: String?
    let priceLevel: Int?
    let rating: Double?
    let geometry: Geometry?
    let userRatingsTotal: Int?
        
    enum CodingKeys: String, CodingKey {
         case name, photos, icon, rating, geometry,
              userRatingsTotal = "user_ratings_total",
              hours = "opening_hours",
              priceLevel = "price_level"
    }
}

struct Geometry: Decodable {
    let location: Location?
}

struct Location: Decodable {
    let lat: Double?
    let lng: Double?
}

struct Hours: Decodable {
    let openNow: Bool
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

struct Photo: Decodable {
    let height: Int?
    let width: Int?
    let photoReference: String?
    
    enum CodingKeys: String, CodingKey {
        case height, width, photoReference = "photo_reference"
    }
}
