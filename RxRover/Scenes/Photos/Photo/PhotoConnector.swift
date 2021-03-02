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
        
        roverLabel.attributedText = NSAttributedString.from(PhotoLogic.roverText(for: photo))
        cameraLabel.attributedText = NSAttributedString.from(PhotoLogic.cameraText(for: photo))
        solLabel.attributedText = NSAttributedString.from(PhotoLogic.solText(for: photo))
        dateLabel.attributedText = NSAttributedString.from(PhotoLogic.dateText(for: photo))
        
        return Observable.never()
            .take(until: rx.deallocating)
    }
}
