//
//  UIView.swift
//  Essentials
//
//  Created by Jordan Kenarov on 10.09.21.
//

import Foundation
import UIKit

public extension UIView {
    func animate(_ animations: [Animations]) {
        guard !animations.isEmpty else { return }
        var animations = animations
        let animation = animations.removeFirst()
        UIView.animate(withDuration: animation.duration) {
            animation.closure(self)
        } completion: { _ in
            self.animate(animations)
        }
    }
}

