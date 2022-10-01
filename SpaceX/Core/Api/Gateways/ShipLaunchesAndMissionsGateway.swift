//
//  ShipLaunchesAndMissionsGateway.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import Foundation

typealias ShipLaunchesAndMissionsGatewayCompletion = (_ result: Result<LauncheOrMissionModel, Error>) -> Void

protocol ShipLaunchesAndMissionsGateway {
    func fetchMission(to flight: Int, completion: @escaping ShipLaunchesAndMissionsGatewayCompletion)
}

final class ApiShipLaunchesAndMissionsGateway: ShipLaunchesAndMissionsGateway {
    func fetchMission(to flight: Int, completion: @escaping ShipLaunchesAndMissionsGatewayCompletion) {
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.version)\(Constants.Endpoint.launches)/\(flight)") else { return  completion(.failure(BadURL()))}
        
        Fetcher<LauncheOrMissionModel>.init(url: url).fetch { result in
            switch result {
            case .success(let mission):
                completion(.success(mission))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
