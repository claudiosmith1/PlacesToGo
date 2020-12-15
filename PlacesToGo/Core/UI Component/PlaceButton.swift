//
//  PlaceButton.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 09/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

class PlaceButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        background()
        roundedCorner()
        setFont()
    }

    private func roundedCorner() {
        layer.cornerRadius = Numbers.buttonCornerRadius
        clipsToBounds = true
        layer.borderWidth = Numbers.buttonBorderWidth
        layer.borderColor = #colorLiteral(red: 0.5869221333, green: 0.8176725569, blue: 0.8804509268, alpha: 0.2925633844)
    }

    private func background() {
        backgroundColor = .clear
    }

    private func setFont() {
        setTitleColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.regular(size: Numbers.filterFontSize)
    }

}
