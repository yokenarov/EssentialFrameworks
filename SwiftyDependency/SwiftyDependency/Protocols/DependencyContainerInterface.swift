//
//  DependencyContainerInterface.swift
//  SwiftyDependency
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
public protocol Dependency: AnyObject {}
extension Dependency {
    public func registerDependency() -> Self {
        DependencyCotainer.register(self)
        return self
    }
}
