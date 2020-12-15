//
//  UIActivityIndicatorViewExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 12/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    func create() {
        guard let frontWindow = UIApplication.shared.keyWindow else { return }
        center = frontWindow.center
        frontWindow.addSubview(self)
        setup()
    }

    func start() {
        guard isAnimating == false else { return }
        isHidden = false
        startAnimating()
    }

    func stop() {
        stopAnimating()
        isHidden = true
    }

    func setup() {
        isHidden = true
        self.style = .white
    }
    
}
