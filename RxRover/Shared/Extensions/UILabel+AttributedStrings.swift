//
//  UILabel+AttributedStrings.swift
//  RxRover
//
//  Created by Greg Price on 03/03/2021.
//

import UIKit

extension UILabel {
    
    func render(stringA: String, attributesA: [NSAttributedString.Key : Any], stringB: String, attributesB: [NSAttributedString.Key : Any]) {
        let typeString = NSAttributedString(string: stringA, attributes: attributesA)
        let startString = NSAttributedString(string:stringB, attributes: attributesB)
        let string = NSMutableAttributedString(attributedString: typeString)
        string.append(NSAttributedString(string: " "))
        string.append(startString)
        self.attributedText = string
    }
}
