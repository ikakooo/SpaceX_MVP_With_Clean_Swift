//
//  ShipsSlideShowConfigurator.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import Foundation

protocol ShipsSlideShowConfigurator {
    func configure(_ controller: ShipsSlideShowViewController)
}

final class ShipsSlideShowConfiguratorImpl: ShipsSlideShowConfigurator {
    
    func configure(_ controller: ShipsSlideShowViewController) {
        let router: ShipsSlideShowRouter = ShipsSlideShowRouterImpl(controller)
        
        let allShipsGateway = ApiAllShipsGateway()
        let allShipsUseCase = ApiAllShipsUseCaseImpl(
            gateway: allShipsGateway)
        
        let presenter: ShipsSlideShowPresenter = ShipsSlideShowPresenterImpl(
            view: controller,
            router: router,
            allShipsUseCase: allShipsUseCase
        )
        
        controller.presenter = presenter
    }
    
}
