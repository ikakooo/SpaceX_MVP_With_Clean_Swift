//
//  CellConfiguration.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import Foundation

protocol CellModel {
    var cellIdentifier: String { get }
}

protocol ConfigurableCell {
    func configure(with model: CellModel)
}

struct SectionModel {
    let headerModel: CellModel?
    let cellModels: [CellModel]
}
