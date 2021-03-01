//
//  PhotosConnector.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxKingfisher
import Kingfisher

extension PhotosViewController {
    func connect() -> Observable<Photo> {

        // will need another observable for segmented control input
        // mapped from index (maybe?) to a Rover
        
        //collectionView.register(PhotosCell.reuseIdentifier) // remove this
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        
        let photos = collectionView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .startWith(())
            .flatMapLatest { apiResponse(from: .getPhotos(for: .curiosity)) }
            .map { $0.photos }
            .share(replay: 1)
        
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
//        Observable.just(photo.imgUrl)
//            .bind(to: imageView.kf.rx.image(options: [.transition(.fade(0.2))]))
        
        
        URLSession.shared.rx
            .data(request: photo.imgRequest)
            .map { UIImage(data: $0) }
            .startWith(UIImage(color: .secondarySystemBackground))
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
