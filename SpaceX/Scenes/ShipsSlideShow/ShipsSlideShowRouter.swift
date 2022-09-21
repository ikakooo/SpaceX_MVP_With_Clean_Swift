//
//  ShipsSlideShowRouter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//


import UIKit

protocol ShipsSlideShowRouter {
    func shipLaunchesAndMissionsPage(of ship: AllShipsModelElement)
}

class ShipsSlideShowRouterImpl: ShipsSlideShowRouter {
    
    private weak var controller: ShipsSlideShowViewController?
    
    init(_ controller: ShipsSlideShowViewController?) {
        self.controller = controller
    }
    
    func shipLaunchesAndMissionsPage(of ship: AllShipsModelElement) {
        let vc = ShipLaunchesAndMissionsViewController()
        vc.ship = ship
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
