//
//  ShipLaunchesAndMissionsConfigurator.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

protocol ShipLaunchesAndMissionsConfigurator {
    func configure(_ controller: ShipLaunchesAndMissionsViewController)
}

final class ShipLaunchesAndMissionsConfiguratorImpl: ShipLaunchesAndMissionsConfigurator {
    
    func configure(_ controller: ShipLaunchesAndMissionsViewController) {
        let router: ShipLaunchesAndMissionsRouter = ShipLaunchesAndMissionsRouterImpl(controller)
        
        
        let presenter: ShipLaunchesAndMissionsPresenter = ShipLaunchesAndMissionsPresenterImpl()
        
        controller.presenter = presenter
    }
    
}
