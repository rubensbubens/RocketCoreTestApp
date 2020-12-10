//
//  UIContextualAction+Custom.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import UIKit

extension UIContextualAction {
    enum UIContextualActionType {
        case more, delete
        
        var title: String {
            switch self {
            case .more:     return "More"
            case .delete:   return "Delete"
            }
        }
        
        var color: UIColor {
            switch self {
            case .more:     return .lightGray
            case .delete:   return #colorLiteral(red: 0.8588235294, green: 0.137254902, blue: 0.3803921569, alpha: 1)
            }
        }
    }
    
    convenience init(type: UIContextualActionType, handler: @escaping UIContextualAction.Handler) {
        self.init(style: .normal, title: type.title, handler: handler)
        setup(with: type.title, color: type.color)
    }
    
    convenience init(title: String?, color: UIColor, handler: @escaping UIContextualAction.Handler) {
        self.init(style: .normal, title: title, handler: handler)
        setup(with: title, color: color)
    }
    
    private func setup(with title: String?, color: UIColor){
        let deleteLabel = UILabel()
        deleteLabel.text = title
        deleteLabel.textColor = .white
        deleteLabel.font = .boldSystemFont(ofSize: 15)
        deleteLabel.sizeToFit()
        
        image = UIImage(view: deleteLabel)
        backgroundColor = color
    }
}

extension UIImage {

    /// This method creates an image of a view
    convenience init?(view: UIView) {

        // Based on https://stackoverflow.com/a/41288197/1118398
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let image = renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }

        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            return nil
        }
    }
}
