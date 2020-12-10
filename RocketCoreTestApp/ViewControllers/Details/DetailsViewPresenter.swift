//
//  DetailsViewPresenter.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import SwiftyAttributes

protocol DetailsView: class {
    func setPoster(url: URL?)
    func setTitle(_ title: String)
    func setSubtitle(_ subtitle: NSAttributedString)
    func setDate(_ date: String)
    func setRating(_ rating: Double)
    func setFavorite(_ isFavorite: Bool)
    func setOverview(_ overview: String)
    
    func setVideos(_ videos: [MovieVideo])
}

protocol DetailsViewPresenterType {
    func updateView()
    func favButtonPressed()
}

struct DetailsViewPresenter: DetailsViewPresenterType {
    weak var view: DetailsView?
    var movie: PopularMovie
    var service: MovieDetailsServiceType = MovieDetailsService()
    var favoritesService: FavoritesServiceType = FavoritesService()
    
    func updateView() {
        view?.setPoster(url: movie.poster)
        view?.setTitle(movie.title)
        
        let subtitle = "• Action, Fantasy, Science Fiction \n• 1h 42m"
        view?.setSubtitle(subtitle.attributedString)
        
        view?.setDate(movie.date?.extended ?? "")
        view?.setRating(movie.rating)
        
        favoritesService.load {
            let isFavorite = favoritesService.isFavoriteMovie(with: movie.id)
            view?.setFavorite(isFavorite)
        }
        
        view?.setOverview(movie.overview)
        
        getVideos()
    }
    
    func getVideos() {
        service.videos(for: movie.id) {
            view?.setVideos($0)
        }
    }
    
    func favButtonPressed() {
        favoritesService.toggleMovie(with: movie.id,
                                     poster: movie.poster,
                                     title: movie.title)
    }
}
