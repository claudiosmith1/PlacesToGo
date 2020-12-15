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
        
        queryItems = addQueryItem(Query.key.photoReference, photoReference, queryItems)
        queryItems = addQueryItem(Query.key.sensor, Query.sensor, queryItems)
        queryItems = addQueryItem(Query.key.maxHeight, height, queryItems)
        queryItems = addQueryItem(Query.key.maxWidth, width, queryItems)
        queryItems = addQueryItem(Query.key.apikey, Query.apikey, queryItems)
        
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
        
    private func addQueryItem(_ name: String, _ value: String?, _ queryItems: [URLQueryItem]) -> [URLQueryItem] {
        var items = queryItems
        items.append(URLQueryItem(name: name, value: value))
        return items
    }
    
    func build() -> URL? {
        return placeUrl
    }
}

struct PlacePhotoUrlBuilder: PlacePhotoUrlBuilderProtocol {
    var placeUrl: URL?
    init() {
        placeUrl = URL(string: "")
    }
}
