//
//  FavoritesViewController.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var presenter: FavoritesViewPresenterType!
    weak var coordinator: PopularCoordinatorType?
    
    //MARK: -
    let tableView = UITableView()
    let emptyLabel = UILabel()
    var rightItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension FavoritesViewController {
    func setup() {
        addViews()
        constraintViews()
        configureViews()
        
        presenter.updateView(animated: false)
    }
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    func constraintViews() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteMovieCell.self)
//        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        emptyLabel.text = "You don't have favorites so far"
        emptyLabel.textColor = .lightGray
        emptyLabel.font = .systemFont(ofSize: 15)
        emptyLabel.textAlignment = .center
        
        rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "trash-icon"), style: .plain, target: self, action: #selector(trashAct))
        rightItem.tintColor = #colorLiteral(red: 0.8588235294, green: 0.137254902, blue: 0.3803921569, alpha: 1)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func trashAct() {
        presenter.removeAll()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteMovieCell = tableView.dequeueCell(forIndexPath: indexPath)
        
        let movie = presenter.movieForRow(at: indexPath)
        
        cell.posterImageView.sd_setImage(with: movie.poster)
        cell.titleLabel.text = movie.title
        
        return cell
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(type: .delete) { [weak self] (action, view, completion) in
            completion(true)
            
            // delay to let action animation be finished first
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.presenter.removeMovie(at: indexPath)
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension FavoritesViewController: FavoritesView {
    func reloadView(animated: Bool) {
        animated
            ? tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            : tableView.reloadData()
        
        emptyLabel.isHidden = tableView.numberOfRows(inSection: 0) > 0
    }
}
