//
//  Constants.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

enum Constants {
    static let baseURL = "https://api.spacexdata.com"
    
    enum Endpoint {
        static let ships = "/ships"
    }
    
    enum Version {
        static let v3 = "/v3"
    }
}
