//
//  PhotoLogic.swift
//  RxRover
//
//  Created by Greg Price on 02/03/2021.
//

import Foundation

enum PhotoLogic {

    typealias TitleValueText = (title: String, value: String)
    
    static func roverText(for photo: Photo) -> TitleValueText {
        ("Rover:", photo.rover.name)
    }
    
    static func cameraText(for photo: Photo) -> TitleValueText {
       ("Camera:", photo.camera.fullName)
    }
    
    static func solText(for photo: Photo) -> TitleValueText {
       ("Martian Sol:", "\(photo.sol)")
    }
    
    // this is not correct!
    static func dateText(for photo: Photo) -> TitleValueText {
        if let date = dateFormatter.date(from: photo.earthDate) {
            return ("Earth Date:", dateFormatter.string(from: date))
        } else {
            return ("Earth Date:", "Unknown")
        }
    }
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
