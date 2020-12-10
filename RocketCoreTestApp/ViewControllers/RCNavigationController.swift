//
//  RCNavigationController.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 08.12.2020.
//

import UIKit

class RCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.prefersLargeTitles = true
    }

}

extension RCNavigationController {
    func setAnimationTransition(type: CATransitionType) {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = type
        
        view.layer.add(transition, forKey: nil)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], transitionType: CATransitionType) {
        setAnimationTransition(type: transitionType)
        super.setViewControllers(viewControllers, animated: false)
    }
}
