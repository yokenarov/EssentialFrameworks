//
//  File.swift
//  Essentials
//
//  Created by Jordan Kenarov on 10.09.21.
//

import Foundation
import UIKit

public struct Animations {
    var duration: TimeInterval
    var closure: (UIView) -> Void
}
public extension Animations {
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
