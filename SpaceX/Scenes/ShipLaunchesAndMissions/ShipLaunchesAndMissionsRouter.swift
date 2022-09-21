//
//  ShipLaunchesAndMissionsRouter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

protocol ShipLaunchesAndMissionsRouter {
}

class ShipLaunchesAndMissionsRouterImpl: ShipLaunchesAndMissionsRouter {
    
    private weak var controller: ShipLaunchesAndMissionsViewController?
    
    init(_ controller: ShipLaunchesAndMissionsViewController?) {
        self.controller = controller
    }
    
}
