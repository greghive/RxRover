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
        
        roverLabel.render(for: PhotoLogic.roverText(for: photo))
        cameraLabel.render(for: PhotoLogic.cameraText(for: photo))
        solLabel.render(for: PhotoLogic.solText(for: photo))
        dateLabel.render(for: PhotoLogic.dateText(for: photo))
        
        return Observable.never()
            .take(until: rx.deallocating)
    }
}
