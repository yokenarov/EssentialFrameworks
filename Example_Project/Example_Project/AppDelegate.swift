//
//  AppDelegate.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 28.10.21.
//

import UIKit
import SwiftyDependency
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Declare your dependencies and instantiate them in the didFinishLaunchingWithOptions.
    var apiManager: ApiManager!
    var exampleVCManager: ExampleVCManager!
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Instantiation of dependencies and registering them in the DC.
        apiManager = ApiManager().registerDependency()
        exampleVCManager = ExampleVCManager().registerDependency()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
