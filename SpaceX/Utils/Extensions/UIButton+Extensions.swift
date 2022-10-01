//
//  UIButton+Extensions.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 29.09.22.
//

import UIKit

extension UIButton {
    func set(image: UIImage? ){
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.setImage(image, for: .normal)
        }, completion: nil)
    }
}
