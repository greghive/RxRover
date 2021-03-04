//
//  Photo+Mocks.swift
//  RxRoverTests
//
//  Created by Greg Price on 04/03/2021.
//

@testable import RxRover
extension Photo {
    static func mock() -> Photo {
        let camera = Camera(id: 1, name: "CMR", roverId: 1, fullName: "Camera")
        let rover = Rover(id: 1, name: "Spirit", landingDate: "2021-03-03", launchDate: "2021-03-03", status: "active")
        return Photo(id: 1, sol: 1, earthDate: "2021-03-03", camera: camera, rover: rover, imgSrc: "https://image")
    }
}
