//
//  ResolvedDependency.swift
//  SwiftyDependency
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
/**
 A propery wrapper meant to only resolve REGISTERED dependencies. Example of use @ResolvedDependency var "yourVariable" : "theTypeOfYourRegisteredDependency"
 */
@propertyWrapper
public class ResolvedDependency<T> {
    public var wrappedValue: T
    public init(){
        wrappedValue = DependencyCotainer.resolve()
    }
}
