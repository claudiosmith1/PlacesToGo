//
//  PlaceControllerCoordinator.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

protocol PlaceControllerProtocol: class {
    func navigateToPlaceDetails(_ viewModel: PlaceViewModel, viewdata: PlaceViewData)
}

class PlaceControllerCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: PlaceControllerProtocol?
    unowned let navigationController: UINavigationController
   
    required init(_ navigator: UINavigationController) {
        self.navigationController = navigator
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.01901422255, green: 0.01893483661, blue: 0.02233588509, alpha: 1)
        self.navigationController.navigationBar.isTranslucent = false
        
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                       NSAttributedString.Key.font: UIFont.regular(size: Numbers.titleFontSize)]
    }
    
    func start() {
        let service: PlaceServiceProtocol = PlaceService()
        let viewModel = PlaceViewModel(service)
        
        let controller = PlaceController().instanceXib()
        controller.viewModel = viewModel
        controller.delegate = self
        navigationController.viewControllers = [controller]
    }
    
}
