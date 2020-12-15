//
//  PlaceControllerLocation.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 11/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import RxSwift
import RxCocoa

extension PlaceController {
    
    func bindGesture() {
        
        view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        tapGesture.rx.event.bind(onNext: { [weak self ] recognizer in
            self?.animatedActionSheet()
        }).disposed(by: disposeBag)
    }
    
    func bindFilterButtonTap() {
        
        filterButton1.rx.tap.bind { [weak self ] in
            self?.getPlaces(with: .bar)
        }.disposed(by: disposeBag)
        
        filterButton2.rx.tap.bind { [weak self ] in
            self?.getPlaces(with: .restaurant)
        }.disposed(by: disposeBag)
        
        filterButton3.rx.tap.bind { [weak self ] in
            self?.getPlaces(with: .cafe)
        }.disposed(by: disposeBag)
    }
    
    func getPlaces(with type: PlaceType) {
        self.indicatorView.start()
        self.filteredLabel.text = type.text
        self.viewModel.fetchPlaces(type: type, currentLocation: currentLocation)
        animatedActionSheet()
    }
    
    func animatedActionSheet(fromCollection: Bool = false) {
        if fromCollection && sheetHeightConstant.constant == Numbers.zeroCGFloat {
           return
        }
        
        let changeInHeight: CGFloat = (sheetHeightConstant.constant == Numbers.zeroCGFloat ?
                                        Numbers.actionSheetHeight : Numbers.zeroCGFloat)
        sheetHeightConstant.constant = changeInHeight
        
        UIView.animate(withDuration: Numbers.actionSheetDurationAnimation) {
                self.view.layoutIfNeeded()
        }
    }
}

extension PlaceController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view else { return false }
        
        if touchView.isDescendant(of: placeActionSheet) { return false }
        if touchView.isDescendant(of: collectionView) || touchView.isDescendant(of: segmentedView) {
           animatedActionSheet(fromCollection: true)
           return false
        }
        return true
    }
}
