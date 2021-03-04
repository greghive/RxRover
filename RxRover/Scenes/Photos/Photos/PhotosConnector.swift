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
                        
        segmentedControl.set(titles: PhotosLogic.roverNames.map { $0.name })
        segmentedControl.selectedSegmentIndex = 2
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        
        let photos = PhotosLogic.triggers(collectionView.refreshControl!.refresh(), segmentedControl.value())
            .flatMapLatest { apiResponse(from: .getPhotos(for: $0)) }
            .map { $0.photos }
            .share(replay: 1)
        
        _ = PhotosLogic.initialLoading(collectionView.refreshControl!.refresh(), segmentedControl.value(), photos)
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        _ = PhotosLogic.refreshLoading(collectionView.refreshControl!.refresh(), segmentedControl.value(), photos)
            .bind(to: collectionView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        _ = photos
            .bind(to: collectionView.rx.items(cellIdentifier: PhotosCell.reuseIdentifier, cellType: PhotosCell.self)) { _, photo, cell in
                cell.bind(with: photo)
            }.disposed(by: disposeBag)
                
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
