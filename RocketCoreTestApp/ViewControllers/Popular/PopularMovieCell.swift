//
//  PopularMovieCell.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit

class PopularMovieCell: BaseCell {

    let roundedView = UIView()
    let posterImageView = UIImageView()
    let ratingView = RatingView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    override func addViews() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(posterImageView)
        roundedView.addSubview(ratingView)
        roundedView.addSubview(titleLabel)
        roundedView.addSubview(dateLabel)
    }
    
    override func constraintViews() {
        roundedView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        
        posterImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(320) 
        }
        
        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(posterImageView.snp.bottom)
            make.left.equalToSuperview().offset(8)
            make.height.width.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).offset(8)
            make.left.equalTo(ratingView)
            make.right.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func configureViews() {
        backgroundColor = .clear
        
        roundedView.backgroundColor = .systemBackground
        roundedView.clipsToBounds = true
        roundedView.layer.cornerRadius = 8
        roundedView.layer.shadowOffset = CGSize(width: 0, height: 3)
        roundedView.layer.shadowOpacity = 0.1
        
        posterImageView.backgroundColor = .secondarySystemBackground
//        posterImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        posterImageView.layer.cornerRadius = 8
//        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Generic Title"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        dateLabel.text = "Generic Date"
        dateLabel.textColor = .secondaryLabel
        dateLabel.font = .systemFont(ofSize: 15)
    }
}
