//
//  UICollectionViewExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 11/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell(_ cell: UICollectionViewCell.Type) {
        
         register(UINib(nibName: cell.init().getClassId(), bundle: nil),
                        forCellWithReuseIdentifier: cell.init().getClassId())
    }

    func register(_ cellType: UICollectionViewCell.Type) {
         register(cellType, forCellWithReuseIdentifier: cellType.init().getClassId())
    }

}

open class BaseCollectionViewCell: UICollectionViewCell {
    
    open func bindData<T>(data: T) {}
}
