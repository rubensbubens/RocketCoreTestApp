//
//  Coordinator.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

protocol Coordinator: class {
    
    /// Starts job of the coordinator.
    func start()
    
    /// Child coordinators to retain. Prevent them from getting deallocated.
    var childCoordinators: [Coordinator] { get set }
    
    /// Stores coordinator to the `childCoordinators` array.
    ///
    /// - Parameter childCoordinator: Child coordinator to store.
    func add(childCoordinator: Coordinator)

    /// Remove coordinator from the `childCoordinators` array.
    ///
    /// - Parameter childCoordinator: Child coordinator to remove.
    func remove(childCoordinator: Coordinator)
    
    /// Navigation controller for coordinator
    var navigation: RCNavigationController { get set }
}

// `Coordinator` default implementation
extension Coordinator {
    
    func add(childCoordinator coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

extension Coordinator {
    
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
