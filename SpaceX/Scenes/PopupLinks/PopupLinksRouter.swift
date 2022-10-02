//
//  PopupLinksRouter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

protocol PopupLinksRouter {
    func openLink(with link: String?)
}

class PopupLinksRouterImpl: PopupLinksRouter {
    
    private weak var controller: PopupLinksViewController?
    
    init(_ controller: PopupLinksViewController?) {
        self.controller = controller
    }
    
    func openLink(with link: String?) {
        
    }
}
