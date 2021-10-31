//
//  DependencyContainer.swift
//  SwiftyDependency
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
/**
 This class is a dependency container, it has the functionality to register and resolove dependencies, whereever it is used.  Before a dependency can be resolved, first it must be declared as a class and then registered, otherwise there are preconditions that will crash your app if it cannot find its dependency. Best practice is to register them in the AppDelegate.didFinishLaunchingWithOptions.
 
 NOTE: There is a convinience propertyWrapper called @ResolvedDependency, which is meant to as the name suggests - resolve a dependency. More @ ResolvedDependency property wrapper.
 */
public class DependencyCotainer {
    private var dependencies = [String : WeakAnyObject]()
    public static var shared = DependencyCotainer()
    private init() {}
    /**
     This function registers the a dependency of type T.
     */
    public static func register<T: Dependency>(_ dependency: T) {
        shared.register(dependency)
    }
    /**
     This function resolves an already registered dependency of type T.
     NOTE: calling this will without registering your dependency first will cause a precondition to crash your app. A suggested alternative is to use the @ResolvedDependency property wrapper to resolve the dependency, but the same warining applies to it as well. 
     */
    public static func resolve<T: Dependency>() -> T {
        shared.resolve()
    }
    private func register<T: Dependency>(_ dependency: T) {
        let key = "\(type(of: T.self))"
        let weakReference = WeakAnyObject(value: dependency as AnyObject) // This helper class helps create a weak reference to the Dependency.
        dependencies[key] = weakReference
    }
    
    private func resolve<T: Dependency>() -> T {
        let key = "\(type(of: T.self))"
        let weakDependency = dependencies[key]
        
        precondition(weakDependency != nil, "No dependency was registered. Check if you forgot to register it in the container.")
        let dependency = weakDependency?.value as? T
        
        precondition(dependency != nil, "Dependency \(T.self) was deallocated and could not be resolved.")
        return dependency!
    }
}
