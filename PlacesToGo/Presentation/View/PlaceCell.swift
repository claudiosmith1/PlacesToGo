//
//  PlaceCell.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 12/12/20.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import Cosmos

class PlaceCell: BaseCollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var openNowLabel: UILabel!
    @IBOutlet var ratingsTotalLabel: UILabel!
    @IBOutlet var starsView: CosmosView!
    
    var place: PlaceViewData! {
        didSet {
            bindData(data: place)
        }
    }
    
    override public func prepareForReuse() {
        starsView.prepareForReuse()
    }

    override func bindData<T>(data: T) {
        guard let model = data as? PlaceViewData else { return }

        nameLabel.text = model.name
        ratingLabel.text = model.rating
        setOpenNow(from: model.openNow)
        
        ratingsTotalLabel.text = model.userRatingsTotal
        showRatings(using: model)
    }
    
    private func setOpenNow(from placeState: PlaceState) {
        openNowLabel.text = placeState.text
        openNowLabel.textColor = placeState.color
    }
    
    func showRatings(using model: PlaceViewData) {
        starsView.rating = model.starsTotal
    }
    
}
