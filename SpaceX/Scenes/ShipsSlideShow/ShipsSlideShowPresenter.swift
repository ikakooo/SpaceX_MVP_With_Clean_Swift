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
    func headerIdentifier(of section: Int) -> String
    func rowIdentifier(at indexPath: IndexPath) -> String
}

final class ShipsSlideShowPresenterImpl: ShipsSlideShowPresenter {
    
    private weak var view: ShipsSlideShowView?
    private var router: ShipsSlideShowRouter
    private let allShipsUseCase: AllShipsUseCase
    
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
                print(allShips)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    var numberOfSections: Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 3
    }
    
    func headerIdentifier(of section: Int) -> String {
        return ""
    }
    
    func rowIdentifier(at indexPath: IndexPath) -> String {
        return ""
    }
    
    
    
}
