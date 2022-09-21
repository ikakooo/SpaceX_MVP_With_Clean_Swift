//
//  ShipLaunchesAndMissionsViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

class ShipLaunchesAndMissionsViewController: UIViewController {
    
    var ship: AllShipsModelElement?
    var presenter: ShipLaunchesAndMissionsPresenter!
    
    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCleanSwift()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCleanSwift()
    }

    // MARK: - Setup ShipLaunchesAndMissionsPresenter

    private func setupCleanSwift() {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ship?.shipName
    }
}
