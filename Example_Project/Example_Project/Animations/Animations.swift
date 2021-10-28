//
//  Animations.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
import UIKit
struct Animations {
    var duration: TimeInterval
    var closure: (UIView) -> Void
}
extension Animations {
    static func fadeIn(duration: TimeInterval) -> Animations {
        return Animations(duration: duration, closure: { $0.alpha = 1 })
    }
    static func fadeOut(duration: TimeInterval) -> Animations {
        return Animations(duration: duration, closure: { $0.alpha = 0 })
    }
    static func scaleTo(to size: CGSize, duration: TimeInterval) -> Animations {
        return Animations(duration: duration, closure: { $0.frame.size = size })
    }
    
    
}
