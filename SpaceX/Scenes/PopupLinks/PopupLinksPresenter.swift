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
    func viewDidLoad()
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
    
    var allLinks: [String] = [] {
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
        let linksCells: [CellModel] = allLinks.map { link in LinksCell.ViewModel(link: link) }
        
        return SectionModel(
            headerModel: nil,
            cellModels: linksCells
        )
    }
    
    func viewDidLoad() {
    
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
