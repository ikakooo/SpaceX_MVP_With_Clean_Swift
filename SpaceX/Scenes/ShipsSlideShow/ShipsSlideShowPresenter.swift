//
//  ShipsSlideShowPresenter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

protocol ShipsSlideShowView: AnyObject {
    func reloadList()
}

protocol ShipsSlideShowPresenter {
    func viewDidLoad()
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func rowIdentifier(at indexPath: IndexPath) -> String
    func configure(row: ConfigurableCell, at indexPath: IndexPath)
    func didTapItem(at indePath: IndexPath)
    var pageDidChanged: ((Int) -> Void)? { get set }
}

final class ShipsSlideShowPresenterImpl: NSObject, ShipsSlideShowPresenter {
        
    private weak var view: ShipsSlideShowView?
    private var router: ShipsSlideShowRouter
    private let allShipsUseCase: AllShipsUseCase
    
    var pageDidChanged: ((Int) -> Void)?
    
    var allShips: [AllShipsModelElement] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    private var listDataSource: [SectionModel] {
        return [
            shipSections
        ]
    }
    
    private var shipSections: SectionModel {
        let shipsCells = allShips.map { shipModel in ShipSlideCell.ViewModel(ship: shipModel)}
        
        return SectionModel(
            headerModel: nil,
            cellModels: shipsCells
        )
    }
    
    init(
        view: ShipsSlideShowView,
        router: ShipsSlideShowRouter,
        allShipsUseCase: AllShipsUseCase
    ){
        self.view = view
        self.router = router
        self.allShipsUseCase = allShipsUseCase
    }
    
    func viewDidLoad() {
        allShipsUseCase.fetchAllShips(){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let allShips):
                self.allShips = allShips
                print(allShips)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapItem(at indePath: IndexPath) {
        router.navigateToShipLaunchesAndMissionsPage(of: allShips[indePath.row])
    }
    
}

extension ShipsSlideShowPresenterImpl {
    
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
