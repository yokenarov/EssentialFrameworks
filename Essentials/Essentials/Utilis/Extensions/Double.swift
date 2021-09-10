//
//  Double.swift
//  Essentials
//
//  Created by Jordan Kenarov on 10.09.21.
//

import Foundation
extension Double {
    func formatted(f: String = "0.2") -> String {
        return String(format: "%\(f)f", self)
    }
}
