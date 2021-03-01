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
        
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        
        let refresh = collectionView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .share()
        
        let photos = refresh
            .startWith(())
            .flatMapLatest { apiResponse(from: .getPhotos(for: .curiosity)) }
            .map { $0.photos }
            .share(replay: 1)
        
        _ = Observable.merge(
                refresh.map(to: true),
                photos.map(to: false))
            .take(until: rx.deallocating)
            .bind(to: collectionView.refreshControl!.rx.isRefreshing)
        
        _ = photos
            .take(1)
            .map(to: false)
            .startWith(true)
            .bind(to: activityView.rx.isAnimating)
        
        _ = photos
            .take(until: rx.deallocating)
            .bind(to: collectionView.rx.items(cellIdentifier: PhotosCell.reuseIdentifier, cellType: PhotosCell.self)) { _, photo, cell in
                cell.bind(with: photo)
            }
        
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
