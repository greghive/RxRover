//
//  TabsConnector.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import UIKit
import Cause_Logic_Effect

extension UITabBarController {
    
    func connect() {
        let photos = UINavigationController().configure { $0.connectPhotos() }
        photos.tabBarItem = .chunky(title: "Photos", icon: "camera.fill", tag: 0)
        viewControllers = [photos]
    }
}
