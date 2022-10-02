//
//  ShipLaunchesAndMissionsRouter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

protocol ShipLaunchesAndMissionsRouter {
    func showPopupLinks(with mission: LauncheOrMissionModel?)
}

class ShipLaunchesAndMissionsRouterImpl: ShipLaunchesAndMissionsRouter {
    
    private weak var controller: ShipLaunchesAndMissionsViewController?
    
    init(_ controller: ShipLaunchesAndMissionsViewController?) {
        self.controller = controller
    }
    
    func showPopupLinks(with mission: LauncheOrMissionModel?) {
        let vc = PopupLinksViewController(mission:mission)
    
        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
    
        controller?.present(vc, animated: true)
    }
    
}
