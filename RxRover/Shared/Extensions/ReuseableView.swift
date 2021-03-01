//
//  Reuseable.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import UIKit

import UIKit

protocol ReuseableView {
    static var reuseIdentifier: String { get }
}

extension ReuseableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableView {}
extension UICollectionViewCell: ReuseableView {}
