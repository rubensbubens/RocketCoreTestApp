//
//  DetailsViewController.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    var presenter: DetailsViewPresenterType!
    weak var coordinator: PopularCoordinatorType?
    
    //MARK: -
    let scrollView = UIScrollView()
    let contentView = UIView()
    let detailsView = UIView()
    let posterImageView = UIImageView()
    let ratingView = RatingView()
    let ratingLabel = UILabel()
    let favButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let dateLabel = UILabel()
    let overviewLabel = UILabel()
    let videosView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension DetailsViewController {
    func setup() {
        addViews()
        constraintViews()
        configureViews()
        
        presenter.updateView()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(detailsView)
        
        detailsView.addSubview(posterImageView)
        detailsView.addSubview(titleLabel)
        detailsView.addSubview(subtitleLabel)
        detailsView.addSubview(dateLabel)
        detailsView.addSubview(ratingView)
        detailsView.addSubview(ratingLabel)
        detailsView.addSubview(favButton)
        detailsView.addSubview(overviewLabel)
        
        contentView.addSubview(videosView)
    }
    
    func constraintViews() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        detailsView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(16)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImageView).offset(8)
            make.left.equalTo(posterImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(subtitleLabel)
        }
        
        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalTo(posterImageView)
            make.height.width.equalTo(56)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingView)
            make.left.equalTo(ratingView.snp.right).offset(8)
        }
        
        favButton.snp.makeConstraints { (make) in
            make.left.equalTo(ratingLabel.snp.right).offset(32)
            make.centerY.equalTo(ratingLabel)
            make.height.width.equalTo(46)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).offset(16)
            make.left.equalTo(posterImageView)
            make.right.equalTo(dateLabel)
            make.bottom.equalToSuperview().inset(16)
        }
        
        videosView.snp.makeConstraints { (make) in
            make.top.equalTo(detailsView.snp.bottom)
            make.left.right.equalTo(detailsView).inset(16)
            make.bottom.equalToSuperview().inset(16)
//            make.height.equalTo(100)
        }
    }
    
    func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.4392156863, alpha: 1) // #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        
        detailsView.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.4392156863, alpha: 1)
        
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        titleLabel.text = "Generic Very Long Multilined Title"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.text = "Generic Subtitle"
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.numberOfLines = 0
        
        dateLabel.text = "Generic Date"
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 15)
        
        ratingLabel.text = "User\nScore"
        ratingLabel.textColor = .white
        ratingLabel.font = .boldSystemFont(ofSize: 15)
        ratingLabel.numberOfLines = 2
        
        favButton.setImage(#imageLiteral(resourceName: "fav-icon"), for: .normal)
        favButton.setImage(#imageLiteral(resourceName: "fav-icon-selected"), for: .selected)
        favButton.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
//        favButton.tintColor = .white
        favButton.makeRounded(height: 46)
        favButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
        
        overviewLabel.text = "Generic overview with very long text to see how it's looking like when there is multiple lines."
        overviewLabel.textColor = .white
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.numberOfLines = 0
        
        videosView.axis = .vertical
        videosView.spacing = 16
    }
}

extension DetailsViewController: DetailsView {
    func setPoster(url: URL?) {
        posterImageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            let color = image?.avgColor
            self?.detailsView.backgroundColor = color
            self?.view.backgroundColor = color
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: NSAttributedString) {
        subtitleLabel.attributedText = subtitle
    }
    
    func setDate(_ date: String) {
        dateLabel.text = date
    }
    
    func setRating(_ rating: Double) {
        ratingView.setRating(rating)
    }
    
    func setFavorite(_ isFavorite: Bool) {
        favButton.isSelected = isFavorite
    }
    
    func setOverview(_ overview: String) {
        overviewLabel.text = overview
    }
    
    func setVideos(_ videos: [MovieVideo]) {
        videos.forEach {
            let view = MovieVideoView()
            videosView.addArrangedSubview(view)
            
            view.thumbImageView.sd_setImage(with: $0.thumbnail)
            view.titleLable.text = $0.name
            
            view.delegate = self 
            view.url = $0.url
            
            videosView.layoutIfNeeded()
        }
    }
}

extension DetailsViewController {
    @objc func favButtonPressed() {
        favButton.isSelected = !favButton.isSelected
        presenter.favButtonPressed()
    }
}

extension DetailsViewController: MovieVideoViewDelegate {
    func didPressPlay(view: MovieVideoView) {
        coordinator?.showVideo(with: view.url)
    }
}
