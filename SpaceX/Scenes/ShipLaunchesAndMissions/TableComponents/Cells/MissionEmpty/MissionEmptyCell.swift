//
//  MissionEmptyCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class MissionEmptyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MissionEmptyCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        // guard let model = model as? ViewModel else { return }
    }
    
}


extension MissionEmptyCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: MissionEmptyCell.self)
        }
    }
    
}
