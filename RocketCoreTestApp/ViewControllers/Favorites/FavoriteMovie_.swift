//
//  FavoriteMovie_.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation

struct FavoriteMovie_: Equatable {
    
    let id: String
    let poster: String
    let title: String
    
    static func == (lhs: FavoriteMovie_, rhs: FavoriteMovie_) -> Bool {
        lhs.id == rhs.id
    }
}

extension FavoriteMovie_ {
    static let mocked = [
        FavoriteMovie_(id: "321", poster: "hjskda", title: "Upside-Down Magic"),
        FavoriteMovie_(id: "123",poster: "u89543", title: "The Dalton Gang")
    ]
}
