//
//  MovieDetailsService.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation

protocol MovieDetailsServiceType {
    func videos(for movieId: String, completion: @escaping (_ videos: [MovieVideo]) -> Void)
}

struct MovieDetailsService: MovieDetailsServiceType {
    var client: NetworkClientType = NetworkClient()
    
    func videos(for movieId: String, completion: @escaping ([MovieVideo]) -> Void) {
        client.videos(for: movieId) { 
            switch $0 {
            case .success(let response):
                completion(map(response: response))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieDetailsService {
    func map(response: [MovieVideoReponse]) -> [MovieVideo] {
        response.map {
            MovieVideo(id: $0.id,
                       key: $0.key,
                       name: $0.name,
                       site: MovieVideo.VideoSite(rawValue: $0.site) ?? .unknown,
                       size: $0.size,
                       type: MovieVideo.VideoType(rawValue: $0.type) ?? .unknown)
        }
    }
}
