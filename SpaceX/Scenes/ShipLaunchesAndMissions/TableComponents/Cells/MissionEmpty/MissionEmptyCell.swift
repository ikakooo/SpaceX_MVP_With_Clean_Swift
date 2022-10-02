//
//  MissionEmptyCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class MissionEmptyCell: UITableViewCell {
}

extension MissionEmptyCell: ConfigurableCell {
    func configure(with model: CellModel) {
    }
}

extension MissionEmptyCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: MissionEmptyCell.self)
        }
    }
}
