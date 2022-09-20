//
//  AllShipsModel.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

typealias AllShipsModel = [AllShipsModelElement]

// MARK: - AllShipsModelElement
struct AllShipsModelElement: Codable {
    let shipID, shipName: String?
    let shipModel: String?
    let shipType: ShipType?
    let roles: [String]?
    let active: Bool?
    let imo, mmsi, abs, allShipsModelClass: Int?
    let weightLbs, weightKg, yearBuilt: Int?
    let homePort: HomePort?
    let status: String?
    let successfulLandings, attemptedLandings: Int?
    let missions: [Mission]?
    let url: String?
    let image: String?
    let attemptedCatches, successfulCatches: Int?

    enum CodingKeys: String, CodingKey {
        case shipID = "ship_id"
        case shipName = "ship_name"
        case shipModel = "ship_model"
        case shipType = "ship_type"
        case roles, active, imo, mmsi, abs
        case allShipsModelClass = "class"
        case weightLbs = "weight_lbs"
        case weightKg = "weight_kg"
        case yearBuilt = "year_built"
        case homePort = "home_port"
        case status
        case successfulLandings = "successful_landings"
        case attemptedLandings = "attempted_landings"
        case missions, url, image
        case attemptedCatches = "attempted_catches"
        case successfulCatches = "successful_catches"
    }
}

enum HomePort: String, Codable {
    case fortLauderdale = "Fort Lauderdale"
    case portCanaveral = "Port Canaveral"
    case portOfLosAngeles = "Port of Los Angeles"
}

// MARK: - Mission
struct Mission: Codable {
    let name: String?
    let flight: Int?
}

enum ShipType: String, Codable {
    case barge = "Barge"
    case cargo = "Cargo"
    case highSpeedCraft = "High Speed Craft"
    case tug = "Tug"
}
