//
//  BaseCell.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit
import SnapKit

class BaseCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        configureViews()
        layoutSubviews()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("required init not implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        constraintViews()
    }
    
    func addViews() { }          // to overload
    func constraintViews() { }   // to overload
    func configureViews() { }    // to overload
    
}

extension BaseCell: ReusableCell { }
extension BaseCell: NibLoadableCell { }
