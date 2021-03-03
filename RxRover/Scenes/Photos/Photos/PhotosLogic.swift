//
//  PhotosLogic.swift
//  RxRover
//
//  Created by Greg Price on 02/03/2021.
//
import RxSwift

enum PhotosLogic {
    
    static let roverNames: [RoverName] = [.spirit, .opportunity, .curiosity]
    
    static func roverName(at index: Int) -> RoverName { roverNames[index] }
    
    static func trigger(_ refreshTrigger: Observable<Void>, _ filterTrigger: Observable<Int>) -> Observable<RoverName> {
        let a = refresh(refreshTrigger, filterTrigger)
        let b = filter(filterTrigger)
        return Observable.merge(a, b)
    }
    
    static func refresh(_ trigger: Observable<Void>, _ selectedIndex: Observable<Int>) -> Observable<RoverName> {
        trigger.withLatestFrom(selectedIndex)
            .map { PhotosLogic.roverName(at: $0) }
    }
    
    static func filter(_ trigger: Observable<Int>) -> Observable<RoverName> {
        trigger.map { PhotosLogic.roverName(at: $0) }
    }
    
    static func photos(from response: Observable<GetPhotosResponse>) -> Observable<[Photo]> {
        response.map { $0.photos }
    }
    
    static func loading(_ start: Observable<Void>, _ complete: Observable<Void>) -> Observable<Bool> {
        Observable.merge(start.map(to: true), complete.map(to: false))
    }
    
    static func initialLoading(_ loading: Observable<Bool>) -> Observable<Bool> {
        loading.take(2)
    }
    
    static func refreshLoading(_ loading: Observable<Bool>) -> Observable<Bool> {
        loading.skip(1)
    }
}
