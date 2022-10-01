//
//  String+Extensions.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 01.10.22.
//

import Foundation

extension String {
    
    func shorted(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + " ..."
    }
}
