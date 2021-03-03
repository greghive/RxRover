//
//  NetworkRequests.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import Foundation

let baseURLString = "https://api.nasa.gov"
let apiKey = "DEMO_KEY"

struct GetPhotosResponse: Decodable {
    let photos: [Photo]
}

extension Endpoint where T == GetPhotosResponse {
    static func getPhotos(for roverName: RoverName, sol: Int = 1000) -> Endpoint {
        var components = URLComponents(string: baseURLString)!
        components.path = "/mars-photos/api/v1/rovers/\(roverName.rawValue)/photos"
        components.queryItems = queryItems(["sol": "\(sol)", "api_key": apiKey])
        return Endpoint(request: URLRequest(url: components.url!), decoder: jsonDecoder)
    }
}

func queryItems(_ dict: [String: String?]) -> [URLQueryItem] {
    return dict.map {
        URLQueryItem(name: $0.key, value: $0.value)
    }
}
