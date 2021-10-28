//
//  TestVC.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
//
//  ViewController.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 23.10.21.
//

import UIKit
import Combine
import GenericViews
import NetworkingAPI
import Essentials
class HomeViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var exampleTitleLabel: UILabel!
    @IBOutlet weak var publisherButton: UIButton!
    @IBOutlet weak var closureButton: UIButton!
    @IBOutlet weak var delegateButton: UIButton!
    @IBAction func pushExampleVC(_ sender: UIButton) {

        switch sender {
        case publisherButton:
            ApiCaller.shared.preferedStyle = .publisher
        case closureButton:
            ApiCaller.shared.preferedStyle = .closure
        case delegateButton:
            ApiCaller.shared.preferedStyle = .delegate
        default: break
        }
    }
    var animations: [Animations] = [.fadeIn(duration: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        publisherButton.setupExampleButton()
        closureButton.setupExampleButton()
        delegateButton.setupExampleButton()
        exampleTitleLabel.setupExampleLabel()
        container.setupContainer()
    }
    override func viewWillAppear(_ animated: Bool) {
        exampleTitleLabel.animate([.fadeOut(duration: 0)])
        publisherButton.animate([.fadeOut(duration: 0)])
        closureButton.animate([.fadeOut(duration: 0)])
        delegateButton.animate([.fadeOut(duration: 0)])
        exampleTitleLabel.animate([.fadeIn(duration: 1)])
        publisherButton.animate([.fadeIn(duration: 1.5)])
        closureButton.animate([.fadeIn(duration: 1.5)])
        delegateButton.animate([.fadeIn(duration: 1.5)])
    }
}
