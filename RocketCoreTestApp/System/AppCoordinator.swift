//
//  AppCoordinator.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation
import UIKit

/** The application's root `Coordinator`. */
final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigation = RCNavigationController()
    
    init(with window: UIWindow) {

        window.rootViewController = navigation
        window.makeKeyAndVisible()
        window.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
    }
    
    func start() {
        let popularCoordinator = PopularCoordinator(navigation: navigation)

        coordinate(to: popularCoordinator)
        add(childCoordinator: popularCoordinator)
    }
}
