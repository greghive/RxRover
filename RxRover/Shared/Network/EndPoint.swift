//
//  EndPoint.swift
//
//  From RxExample created by Daniel Tartaglia
//  Reference: https://github.com/danielt1263/CLE-Architecture-Tools

import Foundation

struct Endpoint<T> {
    let request: URLRequest
    let response: (Data) throws -> T
}

extension Endpoint where T: Decodable {
    init(request: URLRequest, decoder: JSONDecoder) {
        self.request = request
        self.response = { try decoder.decode(T.self, from: $0) }
    }
}

extension Endpoint where T == Void {
    init(request: URLRequest) {
        self.request = request
        self.response = { _ in }
    }
}
