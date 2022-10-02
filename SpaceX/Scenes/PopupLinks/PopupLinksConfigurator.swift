//
//  PopupLinksConfigurator.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import Foundation

protocol PopupLinksConfigurator {
    func configure(_ controller: PopupLinksViewController)
}

final class PopupLinksConfiguratorImpl: PopupLinksConfigurator {
    
    func configure(_ controller: PopupLinksViewController) {
        let router: PopupLinksRouter = PopupLinksRouterImpl(controller)
        
        
        let presenter: PopupLinksPresenter = PopupLinksPresenterImpl(view: controller, router: router)
        
        controller.presenter = presenter
    }
    
}
