//
//  PopularCoordiator.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

protocol PopularCoordinatorType: class {
    func showDetails(for movie: PopularMovie)
    func showVideo(with url: URL)
    func showFavorites()
}

class PopularCoordinator: BaseCoordinator {
    
    override func start() {
        let controller = PopularViewController()
        controller.coordinator = self
        controller.presenter = PopularViewPresenter(view: controller)

        navigation.setViewControllers([controller], transitionType: .fade)
    }
}

extension PopularCoordinator: PopularCoordinatorType {
    func showDetails(for movie: PopularMovie) {
        let controller = DetailsViewController()
        controller.coordinator = self
        controller.presenter = DetailsViewPresenter(view: controller, movie: movie)
        controller.title = "Movie Details"

        navigation.pushViewController(controller, animated: true)
    }
    
    func showVideo(with url: URL) {
        let controller = WebViewController()
        controller.presenter = WebViewPresenter(view: controller, url: url)
        
        navigation.present(controller, animated: true)
    }
    
    func showFavorites() {
        let controller = FavoritesViewController()
        controller.coordinator = self
        controller.presenter = FavoritesViewPresenter(view: controller, service: FavoritesService())
        controller.title = "Favorite Movies"

        navigation.pushViewController(controller, animated: true)
    }
}
