//
//  Coordinator.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 08/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {

    var childCoordinators: [Coordinator] { get set }
    init(_ navigator: UINavigationController)
    
    func start()
}
