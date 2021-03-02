//
//  PhotoConnector.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import RxSwift

extension PhotoViewController {
    func connect(_ photo: Photo) -> Observable<Never> {
        
        URLSession.shared.rx
            .data(request: photo.imgRequest)
            .map { UIImage(data: $0) }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        // move all this to PhotoLogic
        cameraLabel.text = photo.camera.fullName
        solLabel.text = "\(photo.sol)"
        dateLabel.text = photo.earthDate
        roverLabel.text = photo.rover.name
        
        return Observable.never()
            .take(until: rx.deallocating)
    }
}
