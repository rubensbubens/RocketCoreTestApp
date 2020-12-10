//
//  NetworkReachability.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import Network

extension Notification.Name {
    static let kReachabilityChanged = Notification.Name("kReachabilityChanged")
}

class NetworkReachability {
    
    private init() {}
    static let shared = NetworkReachability() 
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkReachabilityMonitor")
    
    private(set) var isReachable = false

    func start() {
        guard monitor.pathUpdateHandler == nil else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                self?.isReachable = true
            case .requiresConnection, .unsatisfied:
                self?.isReachable = false
            @unknown default: break
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .kReachabilityChanged, object: self?.isReachable)
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
        monitor.pathUpdateHandler = nil
    }
}
