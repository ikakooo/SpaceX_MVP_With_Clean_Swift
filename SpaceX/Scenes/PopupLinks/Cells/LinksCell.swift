//
//  LinksCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class LinksCell: UITableViewCell {
    @IBOutlet private weak var linkButton: UIButton!
    
    var link: String?
    
    @IBAction func linkButtonTapped(_ sender: Any) {
        if let url = URL(string: link ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension LinksCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        linkButton.setTitle(model.link.0, for: .normal)
        link = model.link.1
    }
    
}


extension LinksCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: LinksCell.self)
        }
        let link: (String, String)
    }
}
