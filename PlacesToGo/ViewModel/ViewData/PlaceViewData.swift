//
//  PlaceViewData.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

struct PlaceViewData {
    let name: String
    let photo: PhotoViewData?
    let rating: String
    let openNow: PlaceState
    let userRatingsTotal: String?
    let icon: String?
    let starsTotal: Double
    
    init(_ name: String,
         _ photo: PhotoViewData?,
         _ rating: String,
         _ openNow: PlaceState,
         _ userRatingsTotal: String,
         _ icon: String?,
         _ starsTotal: Double) {
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.openNow = openNow
        self.userRatingsTotal = userRatingsTotal
        self.starsTotal = starsTotal
        self.icon = icon
    }
}

struct PhotoViewData {
    let height: Int
    let width: Int
    let photoReference: String?
    
    init(height: Int, width: Int, photoReference: String? = nil) {
        self.height = height
        self.width = width
        self.photoReference = photoReference
    }
}

enum PlaceState: Int {
    case open
    case closed
    
    var text: String {
        switch self {
        case .open: return "Aberto"
        case .closed: return "Fechado"
        }
    }
    var color: UIColor {
        switch self {
        case .open: return #colorLiteral(red: 0.3174016774, green: 0.7104961276, blue: 0.62994802, alpha: 1)
        case .closed: return #colorLiteral(red: 0.8626652106, green: 0.03104315894, blue: 0.1285452836, alpha: 1)
        }
    }
}

enum PlaceSort: Int {
    case rating, name, openNow
}
