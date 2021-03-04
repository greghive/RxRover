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
    
    static func triggers(_ refresh: Observable<Void>, _ filter: Observable<Int>) -> Observable<RoverName> {
        return Observable.merge(
            refresh
                .withLatestFrom(filter)
                .map { PhotosLogic.roverName(at: $0) },
            filter
                .map { PhotosLogic.roverName(at: $0) }
        )
    }
    
    static func initialLoading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ photos: Observable<[Photo]>) -> Observable<Bool> {
        return loading(refresh, filter, photos)
            .take(2)
    }
    
    static func refreshLoading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ photos: Observable<[Photo]>) -> Observable<Bool> {
        return loading(refresh, filter, photos)
            .skip(1)
    }
    
    private static func loading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ photos: Observable<[Photo]>) -> Observable<Bool> {
        return Observable.merge(
                triggers(refresh, filter).map(to: true),
                photos.map(to: false)
        )
    }
}
