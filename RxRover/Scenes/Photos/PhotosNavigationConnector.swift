//
//  PhotosNavigationConnector.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Cause_Logic_Effect

extension UINavigationController {
    
    func connectPhotos() {
        let photos = PhotosViewController().scene { $0.connect() }
        viewControllers = [photos.controller]
        
        _ = photos.action
            .take(until: rx.deallocating)
            .bind(onNext: pushScene(on: self, animated: true, scene: { photo in
                PhotoViewController().scene { $0.connect(photo) }
            }))
    }
}
