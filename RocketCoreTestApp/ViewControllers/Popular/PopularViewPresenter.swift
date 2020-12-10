//
//  PopularViewPresenter.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import Foundation

protocol PopularView: class {
    func setReachability(status: String)
    func setReachable(isReachable: Bool)
    
    func reloadView()
}

protocol PopularViewPresenterType {
    init(view: PopularView, service: PopularMoviesServiceType)
    func updateData()
    func updateReachability()
    
    func viewWillAppear()
    func viewWillDisappear()
    
    func numberOfRows(in section: Int) -> Int
    func movieForRow(at indexPath: IndexPath) -> PopularMovie
}

class PopularViewPresenter: PopularViewPresenterType {
    weak var view: PopularView?
    var service: PopularMoviesServiceType
    
    var movies: [PopularMovie] = []
    
    required init(view: PopularView, service: PopularMoviesServiceType = PopularMoviesService()) {
        self.view = view
        self.service = service
    }
    
    func numberOfRows(in section: Int) -> Int {
        movies.count
    }
    
    func movieForRow(at indexPath: IndexPath) -> PopularMovie {
        movies[indexPath.row]
    }
    
    func updateData() {
        service.updateList { [weak self] in
            self?.movies = $0
            self?.view?.reloadView()
        }
    }
    
    func updateReachability() {
        let isReachable = NetworkReachability.shared.isReachable
        
        view?.setReachable(isReachable: isReachable)
        view?.setReachability(status: isReachable ? "Popular Movies" : "No connection")
    }
    
    func viewWillAppear() {
        NetworkReachability.shared.start()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .kReachabilityChanged, object: nil)
    }
    
    func viewWillDisappear() {
//        NetworkReachability.shared.stop()
//        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reachabilityChanged() {
        updateReachability()
        updateData()
    }
}
