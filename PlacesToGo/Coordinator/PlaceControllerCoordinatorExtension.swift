//
//  PlaceControllerCoordinator.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension PlaceControllerCoordinator: PlaceControllerProtocol {
    
    func navigateToPlaceDetails(_ viewModel: PlaceViewModel, viewdata: PlaceViewData) {
        
        let coordinator = PlaceDetailControllerCoordinator(navigationController)
        coordinator.delegate = self
        coordinator.viewModel = viewModel
        coordinator.viewData = viewdata
        childCoordinators.append(coordinator)
        coordinator.start()
        
    }
}

extension PlaceControllerCoordinator: PlaceDetailCoordinatorProtocol {
    
    func backToPlaceController() {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
