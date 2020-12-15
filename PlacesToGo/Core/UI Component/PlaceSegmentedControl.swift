//
//  SegmentedControl.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

class PlaceSegmentedControl: UISegmentedControl {

    override func layoutSubviews() {
        super.layoutSubviews()
        setFont()
        setBackgroundColor()
    }

    private func setBackgroundColor() {
        backgroundColor = #colorLiteral(red: 0.01637987508, green: 0.06243502688, blue: 0.09746023746, alpha: 1)
        
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = UIColor.white
        } else {}
    }
    
    private func setFont() {
        let fontNormal = [NSAttributedString.Key.font: UIFont.regular(size: Numbers.segmentedFontSize),
                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3450879835, green: 0.3733619802, blue: 0.4113043235, alpha: 1)] as [NSAttributedString.Key : Any]

        setTitleTextAttributes(fontNormal, for: .normal)
        
        let fontSelected = [NSAttributedString.Key.font: UIFont.regular(size: Numbers.segmentedFontSize),
                            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        setTitleTextAttributes(fontSelected, for: .selected)
    }
}
