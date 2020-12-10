//
//  MovieVideoView.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit

protocol MovieVideoViewDelegate: class {
    func didPressPlay(view: MovieVideoView)
}

class MovieVideoView: BaseView {

    let thumbImageView = UIImageView()
    let titleLable = UILabel()
    let playButton = UIButton(type: .system)
    
    weak var delegate: MovieVideoViewDelegate?
    var url: URL!
    
    override func addViews() {
        addSubview(thumbImageView)
        addSubview(titleLable)
        addSubview(playButton)
    }

    override func constraintViews() {
        thumbImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(thumbImageView.snp.width).multipliedBy(0.7)
        }
        
        titleLable.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(16)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(56)
        }
    }
    
    override func configureViews() {
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.clipsToBounds = true
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.backgroundColor = .black
        
        titleLable.textColor = .white
        titleLable.font = .systemFont(ofSize: 15)
        titleLable.numberOfLines = 0
        titleLable.isHidden = true
        
        playButton.addTarget(self, action: #selector(playAct), for: .touchUpInside)
        playButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        playButton.makeRounded(height: 56)
        playButton.setImage(#imageLiteral(resourceName: "play-icon"), for: .normal)
        playButton.tintColor = .white
    }
}

extension MovieVideoView {
    @objc func playAct() {
        delegate?.didPressPlay(view: self)
    }
}
