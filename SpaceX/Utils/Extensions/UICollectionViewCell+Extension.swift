//
//  UICollectionViewCell+Extension.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    func gridAnimationCell(indexPath: IndexPath){
        self.alpha = 0.5
        self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
          self.alpha = 1
          self.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
}
