//
//  FavoritesService.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import UIKit
import CoreData

protocol FavoritesServiceType {
    var movies: [FavoriteMovie] { get }
    
    func load(completion: (() -> Void)?)
    func toggleMovie(with id: String, poster: URL?, title: String)
    func removeMovie(at indexPath: IndexPath)
    func removeAll()
    func isFavoriteMovie(with id: String) -> Bool
}

class FavoritesService: FavoritesServiceType {
    var movies: [FavoriteMovie] = []
    let manager: PersistenceManager
    
    init(manager: PersistenceManager = PersistenceManager.shared) {
        self.manager = manager
    }
    
    func load(completion: (() -> Void)? = nil) {
        movies = PersistenceManager.shared.fetch(FavoriteMovie.self)
        completion?()
    }
    
    func toggleMovie(with id: String, poster: URL?, title: String) {
        if let movie = movies.first(where: { $0.id == id }) {
            remove(movie: movie)
        }
        else {
            createMovie(id: id, poster: poster, title: title)
        }
    }
    
    func removeMovie(at indexPath: IndexPath) {
        remove(movie: movies[indexPath.row])
    }
    
    func removeAll() {
        movies.forEach {
            remove(movie: $0)
        }
    }
    
    func isFavoriteMovie(with id: String) -> Bool {
        movies.contains(where: { $0.id == id })
    }
}

extension FavoritesService {
    func remove(movie: FavoriteMovie) {
        manager.context.delete(movie)
        manager.saveContext()
        load()
    }
    
    func createMovie(id: String, poster: URL?, title: String) {
        let movie = FavoriteMovie(context: manager.context)
        movie.id = id
        movie.poster = poster
        movie.title = title
        
        manager.saveContext()
        load()
    }
}
