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
        let roverName = try PhotosLogic.triggers(refresh, filter)
            .subscribe(on: queueScheduler())
            .toBlocking()
            .toArray()
            .first!
        
        XCTAssertEqual(roverName, .opportunity)
        XCTAssertNotEqual(roverName, .spirit)
        XCTAssertNotEqual(roverName, .curiosity)
    }
    
    func test_initialLoading_outputsTwoValuesOnly() throws {
        let observer = testScheduler.createObserver(Bool.self)
        
        let filter = testScheduler.createHotObservable([
            Recorded.next(100, 1)
        ]).asObservable()
        
        let photos = testScheduler.createHotObservable([
            Recorded.next(200, [Photo.mock()])
        ]).asObservable()

        let refresh = testScheduler.createHotObservable([
            Recorded.next(300, ())
        ]).asObservable()
        
        _ = PhotosLogic.initialLoading(refresh, filter, photos).subscribe(observer)
        testScheduler.start()

        let results = observer
            .events
            .compactMap { $0.value.element }

        XCTAssertEqual(results, [true, false])
        XCTAssertNotEqual(results, [true, false, true, false])
    }
    
    func test_refreshLoading_ignoresFirstValue() throws {
        let observer = testScheduler.createObserver(Bool.self)
        
        let filter = testScheduler.createHotObservable([
            Recorded.next(100, 1)
        ]).asObservable()
        
        let photos = testScheduler.createHotObservable([
            Recorded.next(200, [Photo.mock()]),
            Recorded.next(400, [Photo.mock()])
        ]).asObservable()

        let refresh = testScheduler.createHotObservable([
            Recorded.next(300, ())
        ]).asObservable()
        
        _ = PhotosLogic.refreshLoading(refresh, filter, photos).subscribe(observer)
        testScheduler.start()

        let results = observer
            .events
            .compactMap { $0.value.element }

        XCTAssertEqual(results, [false, true, false])
        XCTAssertNotEqual(results, [true, false, true, false])
    }
    
    private func photos() -> Observable<[Photo]> {
        Observable.just(GetPhotosResponse(photos: [Photo.mock()]).photos)
    }
}
