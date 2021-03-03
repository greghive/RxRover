//
//  Photo.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let earthDate: String
    let camera: Camera
    let rover: Rover
    let imgSrc: String
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

extension Photo {
    
    var imgUrl: URL {
        return URL(string: imgSrc)!
    }
    
    var imgRequest: URLRequest {
        return URLRequest(url: imgUrl)
    }
}
