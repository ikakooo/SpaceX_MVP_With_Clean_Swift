//
//  AllShipsGateway.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

typealias AllShipsGatewayCompletion = (_ result: Result<AllShipsModel, Error>) -> Void

protocol AllShipsGateway {
    func fetchAllShips( completion: @escaping AllShipsGatewayCompletion)
}

final class ApiAllShipsGateway: AllShipsGateway {
    func fetchAllShips(completion: @escaping AllShipsGatewayCompletion) {
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.version)\(Constants.Endpoint.ships)") else { return  completion(.failure(BadURL()))}
        
        Fetcher<AllShipsModel>.init(url: url).fetch { result in
            switch result {
            case .success(let allShips):
                completion(.success(allShips))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

