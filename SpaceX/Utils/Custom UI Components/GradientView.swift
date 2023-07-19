//
//  GradientView.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 03.10.22.
//

import UIKit

@IBDesignable
final class GradientViewUIButton: UIButton {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = cornerRadius
        gradient.borderWidth = borderWidth
        gradient.borderColor = borderColor.cgColor
        
        layer.addSublayer(gradient)
    }
}

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var persent: CGFloat = 50
    var matrixRange = 0...100
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = matrixRange.compactMap{
            CGFloat($0) < persent ? startColor.cgColor : endColor.cgColor
        }
        
        //[startColor.cgColor, endColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

