//
//  ShipSlideCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

class ShipSlideCell: UICollectionViewCell {
    @IBOutlet private weak var shipNameLabel: UILabel!
    @IBOutlet private weak var shipImage: UIImageView!
    @IBOutlet private weak var shipTypeLabel: UILabel!
    @IBOutlet private weak var shipPortLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}



extension ShipSlideCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        shipNameLabel.text = model.ship.shipName
        shipTypeLabel.text = model.ship.shipType?.rawValue
        shipPortLabel.text = model.ship.homePort?.rawValue
        shipImage.loadFrom(URLAddress: model.ship.image ?? Constants.placeholderIMG) 
    }
    
}


extension ShipSlideCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return "ShipSlideCell"
        }
        let ship: AllShipsModelElement
    }
    
}
