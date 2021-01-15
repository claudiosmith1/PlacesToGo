//
//  PlaceController.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 09/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class PlaceController: UIViewController {

    @IBOutlet var filterButton1: UIButton!
    @IBOutlet var filterButton2: UIButton!
    @IBOutlet var filterButton3: UIButton!
    @IBOutlet var placeTypeButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var filteredLabel: UILabel!
    @IBOutlet var placeActionSheet: PlaceActionSheet!
    @IBOutlet var sheetHeightConstant: NSLayoutConstraint!
    @IBOutlet var segmentedView: UIView!
    
    var currentLocation: CLLocation!
    var latitude: Double!
    var longitude: Double!
    var viewModel: PlaceViewModel!
    var delegate: PlaceControllerProtocol?
    var places: [PlaceViewData]!
    
    lazy var locationManager = CLLocationManager()
    lazy var indicatorView = UIActivityIndicatorView()
    
    let observerPlaces = PublishSubject<[PlaceViewData]>()
    let tapGesture = UITapGestureRecognizer()
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    
    private func didLoad() {
        
        sheetHeightConstant.constant = Numbers.zeroCGFloat
        indicatorView.create()
        
        handleCurrentLocation()
        bindGesture()
        bindOpenFilterButtonTap()
        bindFilterButtonTap()
        bindViewModel()
        setVisibility(isHidden: true)
        setupBindingError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    
    private func didAppear() {
        setupCollectionLayout()
        collectionView.registerCell(PlaceCell.self)
    }
    
    private func setVisibility(isHidden: Bool) {
        filteredLabel.isHidden = isHidden
        sortSegmentedControl.isHidden = isHidden
    }
    
    func bindViewModel() {
        viewModel.observerPlaces.observeOn(MainScheduler.instance)
                                     .bind(to: observerPlaces).disposed(by: disposeBag)
        bindingPlaces()
        selectedItem()
    }
        
    private func bindOpenFilterButtonTap() {
        placeTypeButton.rx.tap.bind { [weak self] in
             self?.animatedActionSheet()
        }.disposed(by: disposeBag)
    }
    
    @IBAction func sortAction(_ sender: Any) {
        
        let index = sortSegmentedControl.selectedSegmentIndex
        let sortKey = PlaceSort(rawValue: index) ?? .rating
        viewModel.observableSort(places, using: sortKey)
        
    }

    private func setupBindingError() {
        viewModel.error
            .observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] (error) in
                guard let self = self else { return }
                self.indicatorView.stop()
                
                var errorMessage = error.localizedDescription
                if let error = error as? CustomNetworkError, let message = error.errDescription {
                   errorMessage = message
                }
                self.alert(message: errorMessage, title: nil, completion: {_ in })
            }).disposed(by: disposeBag)
    }

    func setupCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: 97)

        collectionView.collectionViewLayout = layout
    }

    func bindingPlaces() {
        observerPlaces.observeOn(MainScheduler.instance)
            .subscribe (onNext: { [weak self] places in
                 self?.places = places
        }).disposed(by: disposeBag)

        observerPlaces.bind(to: collectionView.rx.items(cellIdentifier: PlaceCell().getClassId(),
                                                        cellType: PlaceCell.self)) {row, data, cell in
            cell.place = data
            self.indicatorView.stop()
            self.setVisibility(isHidden: false)

        }.disposed(by: disposeBag)
    }
    
    func selectedItem() {
        
        collectionView.rx.modelSelected(PlaceViewData.self).subscribe(onNext: { [weak self] (model) in
            guard let self = self else { return }
            if self.checkValidPhoto(viewdata: model) {
                self.viewModel.fetchPhoto(viewdata: model)
                self.delegate?.navigateToPlaceDetails(self.viewModel, viewdata: model)
            }
        }).disposed(by: disposeBag)
    }
    
    private func checkValidPhoto(viewdata: PlaceViewData) -> Bool {
        
        guard viewModel.checkIfHasPhoto(viewdata: viewdata) == true else {
            self.alert(message: "\(viewdata.name) \(Constants.noPhoto)",
                       completion: {_ in })
            return false
        }
        return true
    }

}
