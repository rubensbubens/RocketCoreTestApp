//
//  BaseCoordinator.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigation: RCNavigationController
    
    init(navigation: RCNavigationController = RCNavigationController()) {
        self.navigation = navigation
    }
    
    func start() { } // to override
}
