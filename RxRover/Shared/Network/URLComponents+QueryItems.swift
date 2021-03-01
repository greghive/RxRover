//
//  URLComponents+QueryItems.swift
//
//  From RxExample created by Daniel Tartaglia
//  Reference: https://github.com/danielt1263/CLE-Architecture-Tools

import Foundation

extension URLComponents {
    mutating func addQueryItem<T>(name: String, param: T?, formatted: (T) -> String) {
        guard let param = param else { return }
        let queryItem = URLQueryItem(name: name, value: formatted(param))
        if queryItems == nil {
            queryItems = [queryItem]
        }
        else {
            queryItems!.append(queryItem)
        }
    }
}
