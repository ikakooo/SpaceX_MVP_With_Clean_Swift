//
//  MissionCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 01.10.22.
//

import UIKit

class MissionCell: UITableViewCell {
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var launchYearLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.cornerRadiuse(point: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func linksButtonOnClick(_ sender: Any) {
    }
    
}

extension MissionCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        missionNameLabel.text = model.mission.missionName
        launchYearLabel.text = model.mission.launchYear
        detailLabel.text = model.mission.details?.shorted(to: 50)
    }
    
}


extension MissionCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String {
            return String(describing: MissionCell.self)
        }
        let mission: LauncheOrMissionModel
    }
    
}
