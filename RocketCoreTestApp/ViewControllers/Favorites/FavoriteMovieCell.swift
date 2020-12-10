//
//  FavoriteMovieCell.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit

class FavoriteMovieCell: BaseCell {

    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    
    override func addViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func constraintViews() {
        posterImageView.snp.makeConstraints { (make) in
            // .medium priority to fix broken constraints with standart tableView separator
            // which seems to be giving 0.5pt extra height
            // "<NSLayoutConstraint:0x600002a09950 'UIView-Encapsulated-Layout-Height' UITableViewCellContentView:0x7fd880833d50.height == 80.5   (active)>"
            make.top.left.bottom.equalToSuperview().inset(16).priority(.medium)
            make.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(posterImageView)
            make.left.equalTo(posterImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        backgroundColor = .clear
        
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = "Generic Title"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
    }
}
