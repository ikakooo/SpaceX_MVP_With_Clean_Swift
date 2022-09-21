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
    static let placeholderIMG = "https://i.kym-cdn.com/entries/icons/original/000/027/100/_103330503_musk3.jpg"
}
