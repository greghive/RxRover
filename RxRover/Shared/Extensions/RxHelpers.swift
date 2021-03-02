//
//  RxHelpers.swift
//  RxRover
//
//  Created by Greg Price on 02/03/2021.
//

import RxSwift

extension ObservableConvertibleType {
    func mapVoid() -> Observable<Void> {
        return asObservable().map { _ in }
    }
}
