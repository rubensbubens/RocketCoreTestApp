//
//  PopularMovieResponse.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import SwiftyJSON

struct PopularMovieResponse {
    let id: String
    let poster: String
    let rating: Double
    let title: String
    let date: String
    
    let overview: String
    let backdrop: String
}

extension PopularMovieResponse {
    static func map(from data: Any?) -> [PopularMovieResponse]? {
        guard let data = data else { return nil }
        
        let results = JSON(data)["results"].arrayValue
        
        return results.map {
            PopularMovieResponse(id: $0["id"].stringValue,
                                 poster: $0["poster_path"].stringValue,
                                 rating: $0["vote_average"].doubleValue,
                                 title: $0["title"].stringValue,
                                 date: $0["release_date"].stringValue,
                                 overview: $0["overview"].stringValue,
                                 backdrop: $0["backdrop"].stringValue)
        }
    }
}
