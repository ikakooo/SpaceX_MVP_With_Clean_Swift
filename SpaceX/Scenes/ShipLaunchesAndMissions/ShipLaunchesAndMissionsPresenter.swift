//
//  ShipLaunchesAndMissionsPresenter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

protocol ShipLaunchesAndMissionsView: AnyObject {
    func reloadList()
    func alert(text: String)
}

protocol ShipLaunchesAndMissionsPresenter {
    func viewDidLoad(with missions: [Mission] )
    func fiterMissions(with name: String?, in missions: [Mission])
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func rowIdentifier(at indexPath: IndexPath) -> String
    func configure(row: ConfigurableCell, at indexPath: IndexPath)
}

final class ShipLaunchesAndMissionsPresenterImpl: NSObject, ShipLaunchesAndMissionsPresenter, MissionCellDelegate {
    
    private weak var view: ShipLaunchesAndMissionsView?
    private var router: ShipLaunchesAndMissionsRouter
    private let shipLaunchesAndMissionsUseCase: ShipLaunchesAndMissionsUseCase
    
    
    init(
        view: ShipLaunchesAndMissionsView,
        router: ShipLaunchesAndMissionsRouter,
        shipLaunchesAndMissionsUseCase: ShipLaunchesAndMissionsUseCase
    ){
        self.view = view
        self.router = router
        self.shipLaunchesAndMissionsUseCase = shipLaunchesAndMissionsUseCase
    }
    
    var allmissions: [Mission] = [] {
        didSet {
            translateData()
        }
    }
    
    var allMissionsWithDetails: [LauncheOrMissionModel] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    private var listDataSource: [SectionModel] {
        return [
            missionSections
        ]
    }
    
    private var missionSections: SectionModel {
        var missionCells: [CellModel] = allMissionsWithDetails.map { missionModel in MissionCell.ViewModel(mission: missionModel, delegate: self) }
        
        if missionCells.isEmpty {
            missionCells = [MissionEmptyCell.ViewModel()]
        }
        
        return SectionModel(
            headerModel: nil,
            cellModels: missionCells
        )
    }
    
    private func translateData(){
        allMissionsWithDetails.removeAll()
        allmissions.forEach { mission in
            shipLaunchesAndMissionsUseCase.fetchAllShips(to: mission.flight ?? 0) { [self] result in
                
                switch result {
                case .success(let missionModel):
                    allMissionsWithDetails.append (missionModel)
                case .failure:
                    view?.alert(text: "Internet Connection Error!")
                }
            }
        }
    }
    
    func viewDidLoad(with missions: [Mission] ) {
        self.allmissions = missions
    }
    
    func fiterMissions(with name: String?, in missions: [Mission]) {
        self.allmissions = missions.filter({($0.name?.containsIgnoringCase(find: name ?? "") ?? false)})
    }
    
    func linksButtonOnClick(mission: LauncheOrMissionModel) {
        router.showPopupLinks(with: mission)
    }
}

extension ShipLaunchesAndMissionsPresenterImpl {
    
    var numberOfSections: Int {
        return listDataSource.count
    }

    func numberOfRows(in section: Int) -> Int {
        return listDataSource[section].cellModels.count
    }

    func rowIdentifier(at indexPath: IndexPath) -> String {
        return listDataSource[indexPath.section].cellModels[indexPath.row].cellIdentifier
    }

    func configure(row: ConfigurableCell, at indexPath: IndexPath) {
        row.configure(with: listDataSource[indexPath.section].cellModels[indexPath.row])
    }
    
}
