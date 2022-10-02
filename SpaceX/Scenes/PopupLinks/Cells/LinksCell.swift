//
//  LinksCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class LinksCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension LinksCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        
    }
    
}


extension LinksCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: ShipSlideCell.self)
        }
        let link: String
    }
}
