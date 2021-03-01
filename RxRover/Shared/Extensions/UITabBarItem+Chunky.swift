//
//  UITabBarItem+Chunky.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import UIKit

extension UITabBarItem {
    
    static func chunky(title: String, icon: String, tag: Int) -> UITabBarItem {
        let iconConfig = UIImage.SymbolConfiguration(weight: .heavy).applying(UIImage.SymbolConfiguration(scale: .large))
        let iconImage = UIImage(systemName: icon, withConfiguration: iconConfig)
        return UITabBarItem(title: title, image: iconImage, tag: tag)
    }
}
