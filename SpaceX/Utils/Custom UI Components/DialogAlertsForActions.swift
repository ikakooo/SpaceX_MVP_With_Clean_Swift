//
//  DialogAlertsForActions.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

extension UIViewController {
    func openAlert(title: String,
                   message: String,
                   closeButtonTitle:String,
                   actionAfter: @escaping () -> ())
    {
        let attributedString = NSAttributedString(string: title, attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor : UIColor.red
                ])
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: closeButtonTitle, style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                actionAfter()
            case .cancel:
                print("cancel")
                actionAfter()
            case .destructive:
                print("destructive")
                actionAfter()
                
            @unknown default:
                fatalError()
            }
            
        }))
        self.present(alert, animated: true)
    }
    
}

