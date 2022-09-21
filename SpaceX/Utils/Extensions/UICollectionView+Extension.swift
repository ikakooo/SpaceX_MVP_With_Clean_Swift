//
//  UICollectionView+Extension.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(class: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func deque<T: UICollectionViewCell>(class: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
