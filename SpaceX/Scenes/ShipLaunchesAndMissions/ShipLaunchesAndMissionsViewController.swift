//
//  ShipLaunchesAndMissionsViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

class ShipLaunchesAndMissionsViewController: UIViewController {
    @IBOutlet weak var missionsTableview: UITableView!
    
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
        let configurator = ShipLaunchesAndMissionsConfiguratorImpl()
        configurator.configure(self)
    }
    
    private func setupViews(){
        missionsTableview.dataSource = self
        missionsTableview.delegate = self
        missionsTableview.registerNib(class: MissionCell.self)
    
    }
    
    // MARK: Actions

}

// MARK: UIViewController Lifecycle
extension ShipLaunchesAndMissionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ship?.shipName
        setupViews()
        presenter.viewDidLoad(with: ship?.missions ?? [])
    }
    
}

// MARK: View Protocol Conformation
extension ShipLaunchesAndMissionsViewController: ShipLaunchesAndMissionsView {
    
    func reloadList() {
        DispatchQueue.main.async {
            self.missionsTableview.reloadWithAnimation()
        }
    }
    
}


// MARK: UITableView Delegates
extension ShipLaunchesAndMissionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = presenter.rowIdentifier(at: indexPath)
        let dequeued = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let cell = dequeued as! ConfigurableCell
        presenter.configure(row: cell, at: indexPath)
        return dequeued
    }
}
