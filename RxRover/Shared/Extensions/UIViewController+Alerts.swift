//
//  UIViewController+Alerts.swift
//  RxRover
//
//  Created by Greg Price on 03/03/2021.
//

import UIKit

extension UIViewController {
    
    func showBasicAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

