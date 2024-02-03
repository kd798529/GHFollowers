//
//  UIViewController+EXT.swift
//  GHFollowers
//
//  Created by Kwaku Dapaah on 1/16/24.
//

import UIKit

extension UIViewController {
    
    //this function presents the custom alert on the mainthread when ever it is called
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
