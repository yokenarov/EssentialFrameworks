//
//  Array.swift
//  Essentials
//
//  Created by Jordan Kenarov on 10.09.21.
//

import Foundation
public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
    mutating func remove<T: AnyObject> (_ object: T) -> Bool {
        for (index, element) in self.enumerated() {
            if object === element as? T {
                self.remove(at: index)
                return true
            }
        }
        return false;
    }
}
