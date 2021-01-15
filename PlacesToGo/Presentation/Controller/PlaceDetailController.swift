//
//  PlaceDetailController.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 13/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PlaceDetailControllerProtocol: class {
    func backToPlaceCoordinator()
}

class PlaceDetailController: UIViewController {

    var viewModel: PlaceViewModel!
    weak var delegate: PlaceDetailControllerProtocol?
    var viewdata: PlaceViewData!
    
    let observerPhoto: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    private let disposeBag = DisposeBag()
    
    lazy var imageSize: CGSize = CGSize.zero
    lazy var indicatorView = UIActivityIndicatorView()
    
    var placeImage: UIImageView? = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    
    private func didLoad() {
        self.title = viewdata.name
        
        setupImage()
        indicatorView.create()
        setImageSize()
        
        bindViewModel()
        createBackButton(action: #selector(backAction))
        setupBindingError()
    }
    
    private func setupImage() {
        placeImage?.frame = CGRect.zero
        placeImage?.isHidden = true
        placeImage?.setNeedsDisplay()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
    
    private func bindViewModel() {
        viewModel.observerPhoto.observeOn(MainScheduler.instance)
                                    .bind(to: observerPhoto).disposed(by: disposeBag)
        bindPhoto()
    }
    
    private func setImageSize() {
        guard let data = viewdata, let photo = data.photo else { return }
        imageSize = CGSize(width: photo.width, height: photo.height)
    }
    
    private func setupViews() {
        guard let placeImage = placeImage else { return }
        placeImage.isHidden = false
        
        view.addSubview(placeImage)
        NSLayoutConstraint.activate([
            placeImage.heightAnchor.constraint(equalToConstant: imageSize.height),
            placeImage.widthAnchor.constraint(equalToConstant: imageSize.width),
            placeImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            placeImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func bindPhoto() {
        
        observerPhoto
            .subscribe(onNext: { [weak self] (image) in
                guard let self = self, image != nil else { return }
                self.indicatorView.stop()
                self.placeImage?.image = image
            }).disposed(by: disposeBag)
    }

    @objc func backAction() {
        delegate?.backToPlaceCoordinator()
    }
    
    private func setupBindingError() {
        viewModel.error
            .observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] (error) in
                guard let self = self else { return }
                self.indicatorView.stop()
                
                var errorMessage = error.localizedDescription
                if let error = error as? CustomNetworkError, let message = error.message {
                   errorMessage = message
                }
                self.alert(message: errorMessage, title: nil, completion: {_ in })
            }).disposed(by: disposeBag)
    }
    
}
