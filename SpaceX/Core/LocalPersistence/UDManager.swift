//
//  UDManager.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

class UDManager {
    static let shared = UDManager()

    private init() { }
    
    private var ud = UserDefaults.standard
    
    private let slideShowSpeed = "KEY_slideShowSpeed"


    func save(speed: Float ){ ud.set(speed, forKey: slideShowSpeed) }
    
    func getSpeed() -> Float { ud.float(forKey: slideShowSpeed) }
}
