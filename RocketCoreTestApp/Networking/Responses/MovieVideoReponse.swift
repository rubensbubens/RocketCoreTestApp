//
//  MovieVideoReponse.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import SwiftyJSON

struct MovieVideoReponse {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}

extension MovieVideoReponse {
    static func map(from data: Any?) -> [MovieVideoReponse]? {
        guard let data = data else { return nil }
        
        let results = JSON(data)["results"].arrayValue
        
        return results.map {
            MovieVideoReponse(id: $0["id"].stringValue,
                               key: $0["key"].stringValue,
                               name: $0["name"].stringValue,
                               site: $0["site"].stringValue,
                               size: $0["size"].intValue,
                               type: $0["type"].stringValue)
        }
    }
}
