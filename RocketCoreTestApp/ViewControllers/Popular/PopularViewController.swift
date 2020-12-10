//
//  PopularViewController.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit
import SDWebImage

class PopularViewController: UIViewController {
    
    var presenter: PopularViewPresenterType!
    weak var coordinator: PopularCoordinatorType?
    
    //MARK: -
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var rightItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension PopularViewController {
    func setup() {
        addViews()
        constraintViews()
        configureViews()
        
        presenter.updateReachability()
        presenter.updateData()
    }
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    func constraintViews() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopularMovieCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        activityIndicator.color = .white
        
        rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "fav-icon-big"), style: .plain, target: self, action: #selector(favAct))
        rightItem.tintColor = #colorLiteral(red: 0.8588235294, green: 0.137254902, blue: 0.3803921569, alpha: 1)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func favAct() {
        coordinator?.showFavorites()
    }
}

extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopularMovieCell = tableView.dequeueCell(forIndexPath: indexPath)
        
        let movie = presenter.movieForRow(at: indexPath)
        
        cell.posterImageView.sd_setImage(with: movie.poster)
        cell.ratingView.setRating(movie.rating)
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = movie.date?.extended
        
        return cell
    }
}


extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        coordinator?.showDetails(for: presenter.movieForRow(at: indexPath))
    }
}

extension PopularViewController: PopularView {
    func setReachable(isReachable: Bool) {
        isReachable
            ? activityIndicator.stopAnimating()
            : activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = isReachable ? 1.0 : 0.1
        }
    }
    
    func setReachability(status: String) {
        title = status
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
