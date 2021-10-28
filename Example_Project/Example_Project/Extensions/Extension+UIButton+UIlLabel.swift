//
//  Extension+UIB.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
import UIKit
extension UIButton {
    func setupExampleButton() {
        backgroundColor = .blue
        layer.cornerRadius = 5
        titleLabel?.textColor = .white
    }
}
extension UILabel {
    func setupExampleLabel() {
        backgroundColor = .red
        textColor = .white
    }
}
extension UIView {
    func setupContainer() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
    }
}
