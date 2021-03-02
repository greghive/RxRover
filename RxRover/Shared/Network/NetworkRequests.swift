//
//  NetworkRequests.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import Foundation

let baseURLString = "https://api.nasa.gov"
let apiKey = "6SLK3Bos2lYOnQLpRImRWyb28yty4qV2RnzdVjaa" // ❌ this is a demo...obv don't do this in production! ❌

struct GetPhotosResponse: Decodable {
    let photos: [Photo]
}

//func photosURLComponents(roverName: RoverName) -> URLComponents {
//    var components = URLComponents(string: baseURLString)!
//    components.path = "rovers/\(roverName.rawValue)/photos"
//    return components
//}
//
//func roversURLComponents(roverName: RoverName) -> URLComponents {
//    var components = URLComponents(string: baseURLString)!
//    components.path = "rovers/\(roverName.rawValue)"
//    return components
//}

extension Endpoint where T == GetPhotosResponse {
    static func getPhotos(for roverName: RoverName, sol: Int = 1000) -> Endpoint {
        var components = URLComponents(string: baseURLString)!
        components.path = "/mars-photos/api/v1/rovers/\(roverName.rawValue)/photos"
        components.queryItems = [
            URLQueryItem(name: "sol", value: "\(sol)"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        //let query = components.queryItems = ["sol": "\(sol)", "api_key": apiKey].map { URLQueryItem(name: $0.key, value: $0.value) }
        // create an extension that takes dict????
        return Endpoint(request: URLRequest(url: components.url!), decoder: jsonDecoder)
    }
}

//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=6SLK3Bos2lYOnQLpRImRWyb28yty4qV2RnzdVjaa&sol=1000
