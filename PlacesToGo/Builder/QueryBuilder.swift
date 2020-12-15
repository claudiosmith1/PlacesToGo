//
//  BuilderQuery.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 14/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation

struct QueryBuilder {
    
    func addQueryItem(_ name: String, _ value: String?, _ queryItems: [URLQueryItem]) -> [URLQueryItem] {
        var items = queryItems
        items.append(URLQueryItem(name: name, value: value))
        
        return items
    }
    
}
