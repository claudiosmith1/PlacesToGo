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
        
//        UIVisualEffectView.appearance(whenContainedInInstancesOf: [UIAlertController.classForCoder() as! UIAppearanceContainer.Type]).effect = UIBlurEffect(style: .dark)
        return startCoordinator()
    }
    
    private func startCoordinator() -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        guard let rootController = window?.rootViewController as? UINavigationController else {
            return false
        }
        
        
        // Initialise the first coordinator with the main navigation controller
        coordinator = PlaceControllerCoordinator(rootController)
        
        // The start method will actually display the main view
        coordinator?.start()
        
        window?.makeKeyAndVisible()
        return true
    }


}

