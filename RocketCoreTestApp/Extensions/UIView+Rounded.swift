//
//  UIView+Rounded.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit

extension UIView {
    
    func makeRounded(height: CGFloat? = nil, andClipsToBounds: Bool = true) {
        layer.cornerRadius = (height ?? frame.height) * 0.5
        clipsToBounds = andClipsToBounds
        layoutIfNeeded()
    }
}
