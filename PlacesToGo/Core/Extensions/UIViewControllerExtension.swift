//
//  UIViewControllerExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createBackButton(action: Selector) {
        
        navigationController?.navigationBar.tintColor = .white
        let arrowLeft = UIImage(named: Assets.arrowLeft)
        let backBarItem = UIBarButtonItem(image: arrowLeft, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = backBarItem
    }
    
    func alert(message: String, title: String? = nil, completion: @escaping (_ result: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: Constants.ok, style: .default,
                                      handler: { action in
            completion(true)
        }))
    }
    
    func instanceXib() -> Self {
        return Self(nibName: self.getClassId(), bundle: self.getBundle())
    }
}

extension UINavigationController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }

}
