//
//  PlaceBuilder.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 10/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import CoreLocation

protocol PlaceUrlBuilderProtocol {
    mutating func set(type: PlaceType, currentLocation: CLLocation) -> Self
    var placeUrl: URL? { get set }
    var queryBuilder: QueryBuilder! { get set }
}

extension PlaceUrlBuilderProtocol {
    
    mutating func set(type: PlaceType, currentLocation: CLLocation) -> Self {
        
        let lat = Double(currentLocation.coordinate.latitude)
        let lon  = Double(currentLocation.coordinate.longitude)
        
        getUrl(type, lat, lon)
        return self
    }
   
    mutating func getUrl(_ type: PlaceType, _ lat: Double, _ lon: Double) {

        var components = getURLComponents()
        var queryItems = [URLQueryItem]()
        
        let location = "\(lat),\(lon)"
        queryItems = queryBuilder.addQueryItem(Query.key.location, location, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.radius, Query.radius, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.type, type.querytext, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.apikey, Query.apikey, queryItems)
        
        components.queryItems = queryItems
        placeUrl = components.url
    }

    private func getURLComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        components.path = Endpoint.placePath
        
        return components
    }

    func build() -> URL? {
        return placeUrl
    }
}

struct PlaceUrlBuilder: PlaceUrlBuilderProtocol {
    var queryBuilder: QueryBuilder!
    var placeUrl: URL?
    
    init() {
        placeUrl = URL(string: "")
        queryBuilder = QueryBuilder()
    }
}
