//
//  PlaceDetailControllerCoordinator.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension PlaceDetailControllerCoordinator: PlaceDetailControllerProtocol {
    
    func backToPlaceCoordinator() {
        delegate?.backToPlaceController()
    }

}
