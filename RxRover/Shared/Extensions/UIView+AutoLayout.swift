//
//  UIView+AutoLayout.swift
//  RxRover
//
//  Created by Greg Price on 01/03/2021.
//

import UIKit

extension UIView {
    
    func constrain(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
