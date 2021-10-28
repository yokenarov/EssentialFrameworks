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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var ExampleTitleLabel: UILabel!
    @IBOutlet weak var PublisherButton: UIButton!
    @IBOutlet weak var ClosureButton: UIButton!
    @IBOutlet weak var DelegateButton: UIButton!
    
    @IBAction func pushExampleVC(_ sender: UIButton) {

        switch sender {
        case PublisherButton:
            ApiCaller.shared.preferedStyle = .publisher
        case ClosureButton:
            ApiCaller.shared.preferedStyle = .closure
        case DelegateButton:
            ApiCaller.shared.preferedStyle = .delegate
        default: break
        }
        
    }
    var animations: [Animations] = [.fadeIn(duration: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        PublisherButton.setupExampleButton()
        ClosureButton.setupExampleButton()
        DelegateButton.setupExampleButton()
        ExampleTitleLabel.setupExampleLabel()
        Container.setupContainer()
        
       
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ExampleTitleLabel.animate([.fadeOut(duration: 0)])
        PublisherButton.animate([.fadeOut(duration: 0)])
        ClosureButton.animate([.fadeOut(duration: 0)])
        DelegateButton.animate([.fadeOut(duration: 0)])
        ExampleTitleLabel.animate([.fadeIn(duration: 1)])
        PublisherButton.animate([.fadeIn(duration: 1.5)])
        ClosureButton.animate([.fadeIn(duration: 1.5)])
        DelegateButton.animate([.fadeIn(duration: 1.5)])
    }
}
