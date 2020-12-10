//
//  NetworkResponse.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation
import SwiftyJSON

enum Response {
    case success(JSON)
    case failure(String)
}

enum EmptyResponse {
    case success
    case failure(String)
}

enum ItemResponse<T> {
    case success(T)
    case failure(String)
}

enum CollectionResponse<T> {
    case success([T])
    case failure(String)
}

typealias Completion = (Response) -> ()
typealias EmptyCompletion = (EmptyResponse) -> ()
typealias ItemCompletion<T> = (ItemResponse<T>) -> ()
typealias CollectionCompletion<T> = (CollectionResponse<T>) -> ()
