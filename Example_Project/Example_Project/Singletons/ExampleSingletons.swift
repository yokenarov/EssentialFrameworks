//
//  ExampleSingletons.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
import UIKit
import NetworkingAPI
class ApiCaller: APICallerInterface {
    var preferedStyle: PrefferedStyle = .publisher
    static let shared = ApiCaller()
    private init() {}
}
