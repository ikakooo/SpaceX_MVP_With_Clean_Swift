//
//  PopupLinksPresenter.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

protocol PopupLinksView: AnyObject {
    func reloadList()
}

protocol PopupLinksPresenter {
    func viewDidLoad(allLinks: [String: String?])
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func rowIdentifier(at indexPath: IndexPath) -> String
    func configure(row: ConfigurableCell, at indexPath: IndexPath)
}

final class PopupLinksPresenterImpl:NSObject, PopupLinksPresenter {
    
    
    private weak var view: PopupLinksView?
    private var router: PopupLinksRouter
    
    init(
        view: PopupLinksView,
        router: PopupLinksRouter
    ){
        self.view = view
        self.router = router
    }
    
    var allLinks: [String: String?] = [:] {
        didSet {
            view?.reloadList()
        }
    }
    
    private var listDataSource: [SectionModel] {
        return [
            linksSections
        ]
    }
    
    private var linksSections: SectionModel {
        let linksCells: [CellModel] = allLinks.compactMap { (name,link) in
            if let link = link {
                return   LinksCell.ViewModel(link: (name,link))
            }
            return nil
        }
        
        return SectionModel(
            headerModel: nil,
            cellModels: linksCells
        )
    }
    
    func viewDidLoad(allLinks: [String: String?]) {
        self.allLinks = allLinks //["1":"","dsf1":"dsf","2":"","dsf4":"dsf"]
    }
}

extension PopupLinksPresenterImpl {
    
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
