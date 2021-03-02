//
//  RoverName.swift
//  RxRover
//
//  Created by Greg Price on 02/03/2021.
//

enum RoverName: String {
    case opportunity
    case spirit
    case curiosity
}

extension RoverName {
    var name: String {
        return self.rawValue.prefix(1).uppercased() + self.rawValue.dropFirst()
    }
}
