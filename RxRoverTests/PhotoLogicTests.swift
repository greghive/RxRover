//
//  PhotoLogicTests.swift
//  RxRoverTests
//
//  Created by Greg Price on 03/03/2021.
//

import XCTest
@testable import RxRover

class PhotoLogicTests: XCTestCase {

    func test_roverTextValueForPhoto() {
        XCTAssertEqual(PhotoLogic.roverText(for: photo()).value, "Spirit")
    }
    
    func test_cameraTextValueForPhoto() {
        XCTAssertEqual(PhotoLogic.cameraText(for: photo()).value, "Camera")
    }
    
    func test_solTextValueForPhoto() {
        XCTAssertEqual(PhotoLogic.solText(for: photo()).value, "1000")
    }
    
    func test_dateTextValueForPhoto() {
        XCTAssertEqual(PhotoLogic.dateText(for: photo()).value, "2021-03-03")
    }
    
    private func photo() -> Photo {
        let camera = Camera(id: 1, name: "CMR", roverId: 1, fullName: "Camera")
        let rover = Rover(id: 1, name: "Spirit", landingDate: "2021-03-03", launchDate: "2021-03-03", status: "active")
        return Photo(id: 1, sol: 1000, earthDate: "2021-03-03", camera: camera, rover: rover, imgSrc: "https://image")
    }
}
