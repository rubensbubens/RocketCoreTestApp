//
//  RatingView.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit
import SwiftyAttributes

class RatingView: BaseView {

    let bgView = UIView()
    let progressView = CircularProgressView()
    let valueLabel = UILabel()
    
    override func addViews() {
        addSubview(bgView)
        addSubview(progressView)
        addSubview(valueLabel)
    }
    
    override func constraintViews() {
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgView).inset(3)
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func configureViews() {
        bgView.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.1098039216, blue: 0.1333333333, alpha: 1)
        
        progressView.backgroundColor = .clear
        progressView.trackThickness = 3
        
        setRating(Double(progressView.value))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.makeRounded()
    }
}

extension RatingView {
    func setRating(_ value: Double) {
        let normalized = value / 10
        progressView.value = CGFloat(normalized)
        progressView.progressTint = normalized > 0.5 ? #colorLiteral(red: 0.1294117647, green: 0.8196078431, blue: 0.4784313725, alpha: 1) : normalized > 0.4 ? #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.1960784314, alpha: 1) : normalized > 0 ? #colorLiteral(red: 0.8588235294, green: 0.137254902, blue: 0.3803921569, alpha: 1) : #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        progressView.trackTint = progressView.progressTint.withAlphaComponent(0.3)
        
        let valueString = "\(Int(normalized * 100))".withAttributes([
            .font(Font.boldSystemFont(ofSize: 17)),
            .textColor(.white)
        ])
        let percentageString = "%".withAttributes([
            .font(Font.systemFont(ofSize: 10)),
            .textColor(.white),
            .baselineOffset(5)
        ])
        
        valueLabel.attributedText = valueString + percentageString
    }
}
