//
//  ShipLaunchesAndMissionsUseCase.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import Foundation

typealias ShipLaunchesAndMissionsUseCaseCompletion = (_ result: Result<LauncheOrMissionModel, Error>) -> Void

protocol ShipLaunchesAndMissionsUseCase {
    func fetchAllShips(to flight: Int, completion: @escaping ShipLaunchesAndMissionsUseCaseCompletion)
}

final class ApiShipLaunchesAndMissionsUseCaseImpl: ShipLaunchesAndMissionsUseCase {
    
    private let gateway: ShipLaunchesAndMissionsGateway
    
    init(gateway: ShipLaunchesAndMissionsGateway) {
        self.gateway = gateway
    }
    
    func fetchAllShips(to flight: Int, completion: @escaping ShipLaunchesAndMissionsUseCaseCompletion) {
        gateway.fetchMission(to: flight, completion: completion)
    }
    
}
