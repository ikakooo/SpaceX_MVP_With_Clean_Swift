//
//  ShipsSlideShowViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

class ShipsSlideShowViewController: UIViewController {
    
    var presenter: ShipsSlideShowPresenter!
    
    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCleanSwift()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCleanSwift()
    }

    // MARK: - Setup

    private func setupCleanSwift() {
        let configurator = ShipsSlideShowConfiguratorImpl()
        configurator.configure(self)
    }

}


// MARK: UIViewController Lifecycle
extension ShipsSlideShowViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}


// MARK: View Protocol Conformation
extension ShipsSlideShowViewController: ShipsSlideShowView {
    
    func reloadList() {
        DispatchQueue.main.async {
        }
    }
    
}

