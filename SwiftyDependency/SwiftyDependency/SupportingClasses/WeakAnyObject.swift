//
//  WeakAnyObject.swift
//  SwiftyDependency
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
/**
 This is a class meant to maintain a weak relationship to its value property. The need for this class is necessary because AnyObject is strongly owned and will cause memory leaks.  Assign whatever AnyObject you have to the value of this class to avoid strong retain cycles. 
 */
class WeakAnyObject {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
}
