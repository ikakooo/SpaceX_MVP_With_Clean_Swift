//
//  MissionCell.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 01.10.22.
//

import UIKit

protocol MissionCellDelegate: AnyObject {
    func  linksButtonOnClick(mission: LauncheOrMissionModel)
}

class MissionCell: UITableViewCell {
    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var launchYearLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var mainView: UIView!
    
    private var mission: LauncheOrMissionModel?
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.cornerRadiuse(point: 10)
    }
    
    @IBAction private func linksButtonOnClick(_ sender: Any) {
        guard let mission = mission else { return }
        delegate?.linksButtonOnClick(mission: mission)
    }
    
}

extension MissionCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        mission = model.mission
        delegate = model.delegate
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
        
        weak var delegate: MissionCellDelegate?
    }
    
}
