//
//  ShipSlideCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 21.09.22.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ShipSlideCell_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview{ ShipSlideCell() }
    }
}

#endif

class ShipSlideCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private var  cellContentView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.matrixRange = 0...5
        view.persent = 4
        view.startColor = .black
        view.endColor = .tintColor
        view.cornerRadiuse(point: 20 )
        view.clipsToBounds = true
        view.backgroundColor = .green
        return view
    }()
    
    private var shipNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .tintColor
        label.font = .boldSystemFont(ofSize: 26)
        label.text = "American Champion"
        return label
    }()
    
    private var topLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tintColor
        view.cornerRadiuse(point: 2 )
        
        return view
    }()
    
    private var shipTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 40)
        
        label.text = "Tug"
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    private var shipPortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "Port Of Los Angeless"
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    
    private var shipImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholderIMG")
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadiuse(point: 10 )
        return imageView
    }()
    
    
    // must call super
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()

    }

    // we have to implement this initializer, but will only ever use this class programmatically
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    private func setUpViews(){
        contentView.addSubview(cellContentView)
        cellContentView.addSubview(shipNameLabel)
        cellContentView.addSubview(topLineView)
        cellContentView.addSubview(shipImage)
        cellContentView.addSubview(shipTypeLabel)
        cellContentView.addSubview(shipPortLabel)
        
        
        
        
        
       // contentView.dropShadow()
    }
    
    
    private func setUpConstraints(){
       // contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: self.topAnchor),
            cellContentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            cellContentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            cellContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            shipNameLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            shipNameLabel.leftAnchor.constraint(equalTo: cellContentView.leftAnchor),
            shipNameLabel.rightAnchor.constraint(equalTo: cellContentView.rightAnchor),
            
            topLineView.topAnchor.constraint(equalTo: shipNameLabel.bottomAnchor),
            topLineView.leftAnchor.constraint(equalTo: cellContentView.leftAnchor, constant: 10),
            topLineView.rightAnchor.constraint(equalTo: cellContentView.rightAnchor, constant: -10),
            topLineView.heightAnchor.constraint(equalToConstant: 4),
            
            shipImage.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 10),
            shipImage.leftAnchor.constraint(equalTo: cellContentView.leftAnchor, constant:  10),
            shipImage.rightAnchor.constraint(equalTo: cellContentView.rightAnchor, constant: -10),
            
            shipTypeLabel.topAnchor.constraint(greaterThanOrEqualTo: shipImage.bottomAnchor, constant: 10),
            shipTypeLabel.leftAnchor.constraint(equalTo: cellContentView.leftAnchor, constant:  10),
            shipTypeLabel.rightAnchor.constraint(equalTo: cellContentView.rightAnchor, constant: -10),
            shipTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            shipPortLabel.topAnchor.constraint(equalTo: shipTypeLabel.bottomAnchor, constant: 10),
            shipPortLabel.leftAnchor.constraint(equalTo: cellContentView.leftAnchor, constant:  10),
            shipPortLabel.rightAnchor.constraint(equalTo: cellContentView.rightAnchor, constant: -10),
            shipPortLabel.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant:  -10),
            shipPortLabel.heightAnchor.constraint(equalToConstant: 30)
           
        ])
    }
    
}

extension ShipSlideCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        shipNameLabel.text = model.ship.shipName
        shipTypeLabel.text = model.ship.shipType?.rawValue
        shipPortLabel.text = model.ship.homePort?.rawValue
        shipImage.loadFrom(URLAddress: model.ship.image)

    }
    
}

extension ShipSlideCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: ShipSlideCell.self)
        }
        let ship: AllShipsModelElement
    }
}
