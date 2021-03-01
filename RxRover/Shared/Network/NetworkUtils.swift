//
//  NetworkUtils.swift
//
//  From RxExample created by Daniel Tartaglia
//  Reference: https://github.com/danielt1263/CLE-Architecture-Tools

import Foundation
import RxSwift
import Cause_Logic_Effect

let activityIndicator = ActivityIndicator()
let errorRouter = ErrorRouter()

let jsonDecoder: JSONDecoder = {
    let result = JSONDecoder()
    result.keyDecodingStrategy = .convertFromSnakeCase
    return result
}()

func apiResponse<T>(from endpoint: Endpoint<T>) -> Observable<T> {
    URLSession.shared.rx.data(request: endpoint.request)
        .map(endpoint.response)
        .trackActivity(activityIndicator)
        .rerouteError(errorRouter)
}
