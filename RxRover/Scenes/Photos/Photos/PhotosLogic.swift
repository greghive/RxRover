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
    
    static func trigger(_ refresh: Observable<Void>, _ filter: Observable<Int>) -> Observable<RoverName> {
        return Observable.merge(
            refresh
                .withLatestFrom(filter)
                .map { PhotosLogic.roverName(at: $0) },
            filter
                .map { PhotosLogic.roverName(at: $0) }
        )
    }
    
    static func initialLoading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ response: Observable<[Photo]>) -> Observable<Bool> {
        return loading(refresh, filter, response)
            .take(2)
    }
    
    static func refreshLoading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ response: Observable<[Photo]>) -> Observable<Bool> {
        return loading(refresh, filter, response)
            .skip(1)
    }
    
    private static func loading(_ refresh: Observable<Void>, _ filter: Observable<Int>, _ response: Observable<[Photo]>) -> Observable<Bool> {
        return Observable
            .merge(
                trigger(refresh, filter).map(to: true),
                response.map(to: false)
            )
    }
}
