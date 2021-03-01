//
//  Rover.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

struct Rover: Decodable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
}
