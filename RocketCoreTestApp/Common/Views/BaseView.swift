//
//  BaseView.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit
import SnapKit

class BaseView: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addViews()
        configureViews()
        constraintViews()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("required init not implemented")
    }
    
    /// To override
    func addViews() {
    }
    
    /// To override
    func constraintViews() {
    }
    
    /// To override
    func configureViews() {
    }

}
