//
//  PopupLinksViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class PopupLinksViewController: UIViewController {
    @IBOutlet private weak var shipNameLabel: UILabel!
    @IBOutlet private weak var linksTableview: UITableView!
    
    var presenter: PopupLinksPresenter!
    
    
    var mission: LauncheOrMissionModel? = nil
    
    // MARK: - Object lifecycle
    
    init(mission: LauncheOrMissionModel? ) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
        setupCleanSwift()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCleanSwift()
    }
    
    // MARK: - Setup
    
    private func setupCleanSwift() {
        let configurator = PopupLinksConfiguratorImpl()
        configurator.configure(self)
    }
    
    private func setupViews(){
        linksTableview.dataSource = self
        linksTableview.delegate = self
        linksTableview.registerNib(class: LinksCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shipNameLabel.text = mission?.missionName
        setupViews()
        presenter.viewDidLoad(allLinks: mission?.links?.linksListAsDict() ?? [:])
    }
}


// MARK: View Protocol Conformation
extension PopupLinksViewController: PopupLinksView {
    
    func reloadList() {
        DispatchQueue.main.async {
            self.linksTableview.reloadWithAnimation()
        }
    }
    
}


// MARK: UITableView Delegates
extension PopupLinksViewController: UITableViewDelegate, UITableViewDataSource {
    
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
