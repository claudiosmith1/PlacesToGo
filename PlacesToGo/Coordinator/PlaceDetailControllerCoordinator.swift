//
//  PlaceDetailControllerCoordinator.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

protocol PlaceDetailCoordinatorProtocol: class {
    func backToPlaceController()
}

class PlaceDetailControllerCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var viewModel: PlaceViewModel!
    var viewData: PlaceViewData!
    
    weak var delegate: PlaceDetailCoordinatorProtocol?
    unowned let navigationController: UINavigationController
   
    required init(_ navigator: UINavigationController) {
        self.navigationController = navigator
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.01901422255, green: 0.01893483661, blue: 0.02233588509, alpha: 1)
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func start() {
//        let service: PlaceServiceProtocol = PlaceService()
//        let viewModel = PlaceViewModel(service)
        
        let controller = PlaceDetailController().instanceXib()
        controller.viewModel = viewModel
        controller.viewdata = viewData
        controller.delegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
}
