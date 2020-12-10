//
//  NetworkClient.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation
import Alamofire

protocol NetworkClientType {
    func popularMovies(completion: @escaping CollectionCompletion<PopularMovieResponse>)
    func videos(for movieId: String, completion: @escaping CollectionCompletion<MovieVideoReponse>)
}

struct NetworkClient: NetworkClientType {
    
    func popularMovies(completion: @escaping CollectionCompletion<PopularMovieResponse>) {
        AF.request(url(with: "/movie/popular")).responseJSON {
            let movies = PopularMovieResponse.map(from: $0.value)
            completion(.success(movies ?? []))
        }
    }
    
    func videos(for movieId: String, completion: @escaping CollectionCompletion<MovieVideoReponse>) {
        AF.request(url(with: "/movie/\(movieId)/videos")).responseJSON {
            let movies = MovieVideoReponse.map(from: $0.value)
            completion(.success(movies ?? []))
        }
    }
}

extension NetworkClient {
    func url(with path: String) -> String {
        C.baseUrl + path + "?api_key=" + C.apiKey
    }
}

extension NetworkClient {
    enum C {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let apiKey = "3bb027c92b94786137e24485e3622e25"
    }
}
