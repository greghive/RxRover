//
//  UIViewController+Alerts.swift
//  RxRover
//
//  Created by Greg Price on 03/03/2021.
//

import UIKit
import Cause_Logic_Effect

extension UIViewController {
    
    func basicAlert(title: String? = nil) -> (_ message: String) -> Scene<Never> {
        return { message in
            return UIAlertController(title: title, message: message, preferredStyle: .alert).scene {
                $0.connectOK()
                  .ignoreElements()
            }
        }
    }
}

