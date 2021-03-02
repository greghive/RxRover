//
//  PhotosConnector.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension PhotosViewController {
    func connect() -> Observable<Photo> {
                
        //MARK: config vc
        
        segmentedControl.set(titles: PhotosLogic.roverNames.map { $0.name })
        segmentedControl.selectedSegmentIndex = 0
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        
        //MARK: vc causes
        
        let refresh = collectionView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .mapVoid()
            .share(replay: 1)
        
        let filter = segmentedControl.rx
            .value
            .asObservable()
            .share(replay: 1)
        
        //MARK: wire logic
        
        let trigger = PhotosLogic.trigger(refresh, filter)
            .share(replay: 1)
        
        let response = trigger
            .flatMapLatest { apiResponse(from: .getPhotos(for: $0)) }
        
        let photos = PhotosLogic.photos(from: response)
            .share(replay: 1)
        
        let loading = PhotosLogic.loading(start: trigger.mapVoid(), complete: photos.mapVoid())
            .share(replay: 1)
        
        //MARK: bind UI effects
        
        _ = PhotosLogic.initialLoading(loading: loading)
            .take(until: rx.deallocating)
            .bind(to: activityView.rx.isAnimating)
        
        _ = PhotosLogic.refreshLoading(loading: loading)
            .take(until: rx.deallocating)
            .bind(to: collectionView.refreshControl!.rx.isRefreshing)
        
        _ = photos
            .take(until: rx.deallocating)
            .bind(to: collectionView.rx.items(cellIdentifier: PhotosCell.reuseIdentifier, cellType: PhotosCell.self)) { _, photo, cell in
                cell.bind(with: photo)
            }
        
        //MARK: scene action
        
        return collectionView.rx
            .itemSelected
            .withLatestFrom(photos) { $1[$0.row] }
            .take(until: rx.deallocating)
    }
}

extension PhotosCell {
    func bind(with photo: Photo) {
        URLSession.shared.rx
            .data(request: photo.imgRequest)
            .map { UIImage(data: $0) }
            .startWith(UIImage(color: .secondarySystemBackground))
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
