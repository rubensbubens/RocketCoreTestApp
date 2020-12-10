//
//  PopularMovie.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

struct PopularMovie {
    let id: String
    let poster: URL?
    let rating: Double
    let title: String
    let date: Date?
    
    let overview: String
    let backdrop: URL?
}

//extension PopularMovie {
//    static let mocked = [
//        PopularMovie(id: "671583", poster: "", rating: 0.43, title: "Third", date: Date()),
//        PopularMovie(id: "671583", poster: "", rating: 0.22, title: "Second", date: Date()),
//        PopularMovie(id: "671583", poster: "", rating: 0.76, title: "Fours", date: Date()),
//        PopularMovie(id: "671583", poster: "", rating: 0.91, title: "First", date: Date()),
//    ]
//}
