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
    private init(){}
}


class AlertPresenter {
    static let shared = AlertPresenter()
    private init() {}
    
    func presentAlert(vc: UIViewController, errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "oK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
