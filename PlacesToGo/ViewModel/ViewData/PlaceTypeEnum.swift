//
//  PlaceTypeViewData.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 09/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import UIKit

enum PlaceType: Int {
    case bar
    case restaurant
    case cafe
    
    static let values = [bar, restaurant, cafe]
    
    var text: String {
        switch self {
        case .bar: return "Bar"
        case .restaurant: return "Restaurante"
        case .cafe: return "Café"
        }
    }
    var querytext: String {
        switch self {
        case .bar: return "bar"
        case .restaurant: return "restaurant"
        case .cafe: return "cafe"
        }
    }
}
