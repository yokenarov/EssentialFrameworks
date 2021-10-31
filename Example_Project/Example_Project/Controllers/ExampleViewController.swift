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
import SwiftyDependency
class ExampleViewController: UIViewController {
    @ResolvedDependency var exampleVCManager: ExampleVCManager
    @IBOutlet weak var tableViewContainer: UIView!
    var tableView: GenericTableView!
    var items = [GenericSectionWithItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        switch ApiCaller.shared.preferedStyle {
        case .publisher:
            exampleVCManager.loadTableviewWithPublisherData()
        case .closure:
            exampleVCManager.loadTableViewWithClosureData()
        case .multiThread:
            exampleVCManager.loadRequestWithMultiThreaded()
        case .delegate:
            exampleVCManager.loadTableViewWithDelegate()
        }
    }
    override func viewDidLayoutSubviews() {
        guard self.tableViewContainer != nil else { return }
        guard self.tableView == nil else { return }
        exampleVCManager.tableView = tableView
        exampleVCManager.items = items
        exampleVCManager.setupTableView(tableViewContainer: tableViewContainer)
    }
    deinit {
        print("Sucessfuly deinitialized ExampleViewController. No memory leaks!")
    }
}
