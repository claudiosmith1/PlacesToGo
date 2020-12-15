//
//  PlaceActionSheet.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

class PlaceActionSheet: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        background()
        roundedCorner()
    }
    
    private func roundedCorner() {
        layer.cornerRadius = Numbers.actionSheetCornerRadius
        clipsToBounds = true
        layer.borderColor = #colorLiteral(red: 0.5869221333, green: 0.8176725569, blue: 0.8804509268, alpha: 0.2925633844)
    }

    private func background() {
        backgroundColor = #colorLiteral(red: 0.01637987508, green: 0.06243502688, blue: 0.09746023746, alpha: 1)
    }

}
