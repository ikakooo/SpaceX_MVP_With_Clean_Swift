//
//  UIImageView+Extensions.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String?) {
        guard let URLAddress, let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = loadedImage }
                }
            }
        }
    }
}
