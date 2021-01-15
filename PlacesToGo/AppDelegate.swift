//
//  AppDelegate.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return startCoordinator()
    }
    
    private func startCoordinator() -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        guard let rootController = window?.rootViewController as? UINavigationController else {
            return false
        }

        coordinator = PlaceControllerCoordinator(rootController)
        coordinator?.start()
        
        window?.makeKeyAndVisible()
        return true
    }


}

