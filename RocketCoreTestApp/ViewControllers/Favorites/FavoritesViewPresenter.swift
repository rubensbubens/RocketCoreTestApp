//
//  FavoritesViewPresenter.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation

protocol FavoritesView: class {
    func reloadView(animated: Bool)
}

protocol FavoritesViewPresenterType {
    func updateView(animated: Bool)
    
    func numberOfRows(in section: Int) -> Int
    func movieForRow(at indexPath: IndexPath) -> FavoriteMovie
    
    func removeMovie(at indexPath: IndexPath)
    func removeAll() 
}

struct FavoritesViewPresenter: FavoritesViewPresenterType {
    weak var view: FavoritesView?
    var service: FavoritesServiceType!
    
    func updateView(animated: Bool) {
        service.load {
            view?.reloadView(animated: animated)
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        service.movies.count
    }
    
    func movieForRow(at indexPath: IndexPath) -> FavoriteMovie {
        service.movies[indexPath.row]
    }
    
    func removeMovie(at indexPath: IndexPath) {
        service.removeMovie(at: indexPath)
        view?.reloadView(animated: true)
    }
    
    func removeAll() {
        service.removeAll()
        view?.reloadView(animated: true)
    }
}
