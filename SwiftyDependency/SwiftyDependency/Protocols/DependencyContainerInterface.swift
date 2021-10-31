//
//  DependencyContainerInterface.swift
//  SwiftyDependency
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
 protocol DependencyContainerInterface {
    var dependencies: [String: WeakAnyObject] { get set }
}
public protocol Dependency: AnyObject {}
