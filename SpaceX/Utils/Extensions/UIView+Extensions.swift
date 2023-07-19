//
//  UIView+Extensions.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

extension UIView {
    
    func cornerRadiuse(point: CGFloat){
        layer.cornerRadius = point
        layer.masksToBounds = true
    }
    
    func dropShadow(scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.label.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = .zero
            layer.shadowRadius = 5
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
}
