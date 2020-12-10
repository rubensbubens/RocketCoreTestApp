//
//  MovieVideo.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation

struct MovieVideo {
    enum VideoType: String {
        case teaser = "Teaser"
        case trailer = "Trailer"
        case featurette = "Featurette"
        case clip = "Clip"
        case unknown
    }
    
    enum VideoSite: String {
        case youtube = "YouTube"
        case unknown
    }
    
    let id: String
    let key: String
    let name: String
    let site: VideoSite
    let size: Int
    let type: VideoType
    
    var url: URL? {
        switch site {
        case .youtube: return URL(string: "https://www.youtube.com/watch?v=" + key)
        case .unknown: return nil
        }
    }
    
    var thumbnail: URL? {
        switch site {
        case .youtube: return URL(string: "https://img.youtube.com/vi/\(key)/0.jpg")
        case .unknown: return nil
        }
    }
}
