//
//  PopularMoviesService.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

protocol PopularMoviesServiceType {
    func updateList(completion: @escaping (_ movies: [PopularMovie]) -> Void)
}

struct PopularMoviesService: PopularMoviesServiceType {
    var client: NetworkClientType = NetworkClient()
    
    func updateList(completion: @escaping (_ movies: [PopularMovie]) -> Void) {
        client.popularMovies {
            switch $0 {
            case .success(let response):
                completion(map(response: response))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PopularMoviesService {
    func map(response: [PopularMovieResponse]) -> [PopularMovie] {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        
        let imageUrl: String = "https://image.tmdb.org/t/p/w500"
        
        return response.map {
            PopularMovie(id: $0.id,
                         poster: URL(string: imageUrl + $0.poster),
                         rating: $0.rating,
                         title: $0.title,
                         date: formatter.date(from: $0.date),
                         overview: $0.overview,
                         backdrop: URL(string: imageUrl + $0.backdrop))
        }
    }
}
