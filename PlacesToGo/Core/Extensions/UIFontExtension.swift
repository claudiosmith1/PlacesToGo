//
//  UIFontExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension UIFont {
    
    static var family: String {
        get { return "Avenir" }
    }
    
    static var familyRegular: String {
        get { return "\(family)-regular" }
    }
    static var familyBold: String {
        get { return "\(family)-bold" }
    }
    
    static func regular(size: CGFloat) -> UIFont {
        guard let reg = Self.init(name: UIFont.familyRegular, size: size) else {
            return Self.systemFont(ofSize: size)
        }
        return reg
    }
    
    static func bold(size: CGFloat) -> UIFont {
        guard let reg = Self.init(name: UIFont.familyBold, size: size) else {
            return Self.systemFont(ofSize: size)
        }
        return reg
    }
}
