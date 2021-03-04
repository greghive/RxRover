//
//  PhotosLogicTests.swift
//  RxRoverTests
//
//  Created by Greg Price on 02/03/2021.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import RxRover

class PhotosLogicTests: XCTestCase {

    var testScheduler: TestScheduler!
    var testSubscription: Disposable!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        super.tearDown()
        testScheduler.scheduleAt(1000) {
            self.testSubscription.dispose()
        }
    }
    
    private func queueScheduler() -> ConcurrentDispatchQueueScheduler {
        ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    func test_roverNameAtIndex_outputsCorrectRoverName() {
        XCTAssertTrue(PhotosLogic.roverName(at: 0) == .spirit)
        XCTAssertTrue(PhotosLogic.roverName(at: 1) == .opportunity)
        XCTAssertTrue(PhotosLogic.roverName(at: 2) == .curiosity)
    }
    
    func test_trigger_outputsCorrectRoverName() throws {
        let refresh = Observable.just(())
        let filter = Observable.just(1)
        let roverName = try PhotosLogic.trigger(refresh, filter)
            .subscribe(on: queueScheduler())
            .toBlocking()
            .toArray()
            .first!
        
        XCTAssertEqual(roverName, .opportunity)
        XCTAssertNotEqual(roverName, .spirit)
        XCTAssertNotEqual(roverName, .curiosity)
    }
    
//    func test_refreshSelectedIndex_outputsCorrectRoverName() throws {
//        let trigger = Observable.just(())
//        let index = Observable.just(1)
//        let roverName = try PhotosLogic.refresh(trigger, index)
//            .subscribe(on: queueScheduler())
//            .toBlocking()
//            .toArray()
//            .first!
//
//        XCTAssertEqual(roverName, .opportunity)
//        XCTAssertNotEqual(roverName, .spirit)
//        XCTAssertNotEqual(roverName, .curiosity)
//    }
    
//    func test_filterSelectedIndex_outputsCorrectRoverName() throws {
//        let roverName = try PhotosLogic.filter(Observable.just(2))
//            .subscribe(on: queueScheduler())
//            .toBlocking()
//            .toArray()
//            .first!
//
//        XCTAssertEqual(roverName, .curiosity)
//        XCTAssertNotEqual(roverName, .spirit)
//        XCTAssertNotEqual(roverName, .opportunity)
//    }
    
//    func test_photosFromResponse_outputsPhotos() throws {
//        let camera = Camera(id: 1, name: "CMR", roverId: 1, fullName: "Camera")
//        let rover = Rover(id: 1, name: "Spirit", landingDate: "2021-03-03", launchDate: "2021-03-03", status: "active")
//        let photosIn = [Photo(id: 1, sol: 1, earthDate: "2021-03-03", camera: camera, rover: rover, imgSrc: "https://image")]
//        let response = Observable.just(GetPhotosResponse(photos: photosIn))
//
//        let photosOut = try PhotosLogic.photos(from: response)
//            .subscribe(on: queueScheduler())
//            .toBlocking()
//            .toArray()
//            .first!
//
//        XCTAssertEqual(photosOut, photosIn)
//    }
    
//    func test_loading() throws {
//        let observer = testScheduler.createObserver(Bool.self)
//
//        let start = testScheduler.createHotObservable([
//            Recorded.next(100, ()),
//            Recorded.next(300, ())
//        ]).asObservable()
//
//        let complete = testScheduler.createHotObservable([
//            Recorded.next(200, ()),
//            Recorded.next(400, ())
//        ]).asObservable()
//
//        _ = PhotosLogic.loading(start, complete).subscribe(observer)
//        testScheduler.start()
//
//        let results = observer
//            .events
//            .compactMap { $0.value.element }
//
//        XCTAssertEqual(results, [true, false, true, false])
//    }
    
//    func test_initialLoading_outputsTwoValuesOnly() throws {
//        let observer = testScheduler.createObserver(Bool.self)
//        let loading = testScheduler.createHotObservable([
//            Recorded.next(100, true),
//            Recorded.next(200, false),
//            Recorded.next(300, true),
//            Recorded.next(400, false)
//        ]).asObservable()
//
//        _ = PhotosLogic.initialLoading(loading).subscribe(observer)
//        testScheduler.start()
//
//        let results = observer
//            .events
//            .compactMap { $0.value.element }
//
//        XCTAssertEqual(results, [true, false])
//        XCTAssertNotEqual(results, [true, false, true, false])
//    }
    
//    func test_refreshLoading_ignoresFirstValue() throws {
//        let observer = testScheduler.createObserver(Bool.self)
//        let loading = testScheduler.createHotObservable([
//            Recorded.next(100, true),
//            Recorded.next(200, false),
//            Recorded.next(300, true),
//            Recorded.next(400, false)
//        ]).asObservable()
//        
//        _ = PhotosLogic.refreshLoading(loading).subscribe(observer)
//        testScheduler.start()
//        
//        let results = observer
//            .events
//            .compactMap { $0.value.element }
//        
//        XCTAssertEqual(results, [false, true, false])
//    }
}
