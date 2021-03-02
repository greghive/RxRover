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
    
    static func trigger(trigger: Observable<Void>, selectedIndex: Observable<Int>) -> Observable<RoverName> {
       
        let refresh = trigger
            .withLatestFrom(selectedIndex)
            .map { PhotosLogic.roverName(at: $0) }
        
        let filter = selectedIndex
            .map { PhotosLogic.roverName(at: $0) }
        
        return Observable.merge(refresh, filter)
    }
    
//    static func refresh(trigger: Observable<Void>, selectedIndex: Observable<Int>) -> Observable<RoverName> {
//        trigger.withLatestFrom(selectedIndex)
//            .map { PhotosLogic.roverName(at: $0) }
//    }
//    
//    static func filter(trigger: Observable<Int>) -> Observable<RoverName> {
//        trigger.map { PhotosLogic.roverName(at: $0) }
//    }
    
    static func photos(from response: Observable<GetPhotosResponse>) -> Observable<[Photo]> {
        response.map { $0.photos }
    }
    
    static func loading(start: Observable<Void>, complete: Observable<Void>) -> Observable<Bool> {
        Observable.merge(start.map(to: true), complete.map(to: false))
    }
    
    static func initialLoading(loading: Observable<Bool>) -> Observable<Bool> {
        loading.take(2)
    }
    
    static func refreshLoading(loading: Observable<Bool>) -> Observable<Bool> {
        loading.skip(1)
    }
}
