//
//  UIKit+RxHelpers.swift
//  RxRover
//
//  Created by Greg Price on 04/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension UIRefreshControl {
    func refresh() -> Observable<Void> {
        rx.controlEvent(.valueChanged).asObservable()
    }
}

extension UISegmentedControl {
    func value() -> Observable<Int> {
        rx.value.asObservable()
    }
}

