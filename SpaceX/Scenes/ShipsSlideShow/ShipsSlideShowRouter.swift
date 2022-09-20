//
//  ShipsSlideShowRouter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//


import UIKit

protocol ShipsSlideShowRouter {
    func navigateToDetailsPage(of city: String)
}

class ShipsSlideShowRouterImpl: ShipsSlideShowRouter {
    
    private weak var controller: ShipsSlideShowViewController?
    
    init(_ controller: ShipsSlideShowViewController?) {
        self.controller = controller
    }
    
    func navigateToDetailsPage(of city: String) {
        let vc = UIViewController()
        vc.title = "\(city)"
        vc.view.backgroundColor = .white
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
