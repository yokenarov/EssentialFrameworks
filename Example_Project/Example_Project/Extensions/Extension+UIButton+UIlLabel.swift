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
        backgroundColor = .systemTeal
        layer.cornerRadius = 5
        titleLabel?.textColor = .white
    }
}
extension UILabel {
    func setupExampleLabel() {
        layer.cornerRadius = 5
        backgroundColor = .systemTeal
        textColor = .white
    }
}
extension UIView {
    func setupContainer() {
        backgroundColor = .white.withAlphaComponent(1)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
    }
}
