//
//  AllShipsUseCase.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

typealias AllShipsUseCaseCompletion = (_ result: Result<AllShipsModel, Error>) -> Void

protocol AllShipsUseCase {
    func fetchAllShips( completion: @escaping AllShipsUseCaseCompletion)
}

final class ApiAllShipsUseCaseImpl: AllShipsUseCase {
    
    private let gateway: AllShipsGateway
    
    init(gateway: AllShipsGateway) {
        self.gateway = gateway
    }
    
    func fetchAllShips( completion: @escaping AllShipsUseCaseCompletion) {
        gateway.fetchAllShips( completion: completion)
    }
    
}

