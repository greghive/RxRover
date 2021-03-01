//
//  UICollectionView+Cells.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import UIKit

extension UICollectionView {
    
    func register(_ identifier: String) {
        register(identifiers: [identifier])
    }
    
    func register(identifiers : [String]) {
        for identifier in identifiers {
            self.register(Bundle.main.classNamed(identifier), forCellWithReuseIdentifier: identifier)
        }
    }
}
