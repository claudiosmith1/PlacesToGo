//
//  PlacesConstants.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import UIKit

struct Endpoint {
    static let scheme = "https"
    static let host = "maps.googleapis.com"
    static let placePath = "/maps/api/place/nearbysearch/json"
    static let photoPath = "/maps/api/place/photo"
}

struct Query {

    struct key {
        static let location = "location"
        static let type = "type"
        static let radius = "radius"
        static let keyword = "keyword"
        static let apikey = "key"
        static let photoReference = "photoreference"
        static let sensor = "sensor"
        static let maxHeight = "maxheight"
        static let maxWidth = "maxwidth"
    }
    
    static let sensor = "false"
    static let radius = "1500"
    static let apikey = "AIzaSyAvWKZWVVVOYP7_KSK3VT8sG0_eT7Xnyno"
}

struct Constants {
    static let backgroundAlert = #colorLiteral(red: 0.1729443916, green: 0.1617187862, blue: 0.1567400009, alpha: 0.9065263856)
    static let json = "json"
    static let fileNotFound = "couldn't find the file"
    static let emptyString = ""
    static let cancel = "Cancelar"
    static let sort = "Ordenar"
    static let filter = "Filtrar"
    static let ok = "Ok"
    static let minStatusSuccess = 200
    static let maxStatusSuccess = 300
    static let alertBug = "width == - 16"
    static let permissionError = "É necessário permitir a sua localização no app."
    static let noPhoto = "não possui foto."
}

struct Numbers {
    static let thousand: Double = 1000
    static let zeroCGFloat: CGFloat = 0
    static let zeroInt: Int = 0
    static let zeroFloat: Float = 0
    static let oneFloat: Float = 0
    static let zeroDuration: TimeInterval = 0
    static let zeroDouble: Double = 0
    static let oneInt: Int = 1
    static let oneCGFloat: CGFloat = 1
    static let oneNumber: NSNumber = 1
    static let segmentedFontSize: CGFloat = 13
    static let titleFontSize: CGFloat = 16
    static let filterFontSize: CGFloat = 17
    static let errorCodePermission = 999
    static let buttonCornerRadius: CGFloat = 25
    static let buttonBorderWidth: CGFloat = 0.5
    static let actionSheetCornerRadius: CGFloat = 25
    static let actionSheetHeight: CGFloat = 210
    static let actionSheetDurationAnimation: Double = 0.3
}

struct Assets {
    static let arrowLeft = "arrowLeft"
    static let background = "black"
}
