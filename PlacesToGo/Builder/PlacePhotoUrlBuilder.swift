//
//  PlaceBuilder.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 10/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

protocol PlacePhotoUrlBuilderProtocol {
    mutating func set(_ viewdata: PlaceViewData) -> Self
    var placeUrl: URL? { get set }
    var queryBuilder: QueryBuilder! { get set }
}

extension PlacePhotoUrlBuilderProtocol {
    
    mutating func set(_ viewdata: PlaceViewData)  -> Self {
        
        setPhotoUrl(viewdata)
        return self
    }
    
    mutating func setPhotoUrl(_ viewdata: PlaceViewData) {

        var components = getURLComponents()
        var queryItems = [URLQueryItem]()
        
        guard let photoReference = viewdata.photo?.photoReference,
              let height = viewdata.photo?.height.description,
              let width = viewdata.photo?.width.description else { return }
        
        queryItems = queryBuilder.addQueryItem(Query.key.photoReference, photoReference, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.sensor, Query.sensor, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.maxHeight, height, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.maxWidth, width, queryItems)
        queryItems = queryBuilder.addQueryItem(Query.key.apikey, Query.apikey, queryItems)
        
        components.queryItems = queryItems
        placeUrl = components.url
    }
    
    private func getURLComponents() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        components.path = Endpoint.photoPath
        
        return components
    }

    func build() -> URL? {
        return placeUrl
    }
}

struct PlacePhotoUrlBuilder: PlacePhotoUrlBuilderProtocol {
    var placeUrl: URL?
    var queryBuilder: QueryBuilder!
    
    init() {
        placeUrl = URL(string: Constants.emptyString)
        queryBuilder = QueryBuilder()
    }
}
