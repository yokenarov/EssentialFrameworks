//
//  ExampleVCManager.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 31.10.21.
//

import Foundation
import SwiftyDependency
import GenericViews
import Combine
import NetworkingAPI
import UIKit
class ExampleVCManager: Dependency, DataTaskWithDelegate {
    @ResolvedDependency var apiServiceManager: ApiManager
    var cancellableBag = Set<AnyCancellable>()
    var tableView: GenericTableView?
    var items: [GenericSectionWithItems]?
    func loadTableviewWithPublisherData() {
        apiServiceManager.loadRequestWithPublisher()
            .sink { [weak self] _ in
                self?.tableView?.reloadData()
            } receiveValue: { [weak self] users in
                users.forEach { user in
                    let blue = Blue()
                    blue.title = user.name ?? ""
                    self?.items?[0].items.append(blue)
                }
            }.store(in: &cancellableBag)
    }
    func loadTableViewWithClosureData() {
        apiServiceManager.loadRequestWithClosure { [weak self] genericItem in
            self?.items?[0].items = genericItem.items
            self?.tableView?.reloadData()
        }
    }
    // MARK: - MultiThreaded
    func loadRequestWithMultiThreaded() {
        apiServiceManager.loadRequestWithMultiThreaded { arrayOfGenericModelType in
            self.items?[0].items = arrayOfGenericModelType
            self.tableView?.reloadData()
        }
    }
    // MARK: - DelegateMethod
    func loadTableViewWithDelegate() {
        ApiCaller.shared.makeURLRequestWithDelegate(
            for: ApiRequests.comments(location: .url, params: ["postId": "1"]),
               with: Array<Post>.self, dataTaskDelegateImplementor: self)
    }
    func resultFromURLRequestWithDelegate(model: Codable?, responseAndData: ResponseAndData?) {
        responseAndData?.printResponseStatus(file: #file, function: #function, line: #line)
        DispatchQueue.main.async {
            guard let unwrappedPosts = model as? [Post] else { return }
            unwrappedPosts.forEach { post in
                let blue = Blue()
                blue.title = post.name ?? ""
                self.items?[0].items.append(blue)
                self.tableView?.reloadData()
            }
        }
    }
    // MARK: - Setup Tableview
    func setupTableView(tableViewContainer: UIView) {
        let genericItem  = GenericSectionWithItems(
            sectionLableBuilder: SectionLableBuilder(sectiontext: "", fontSize: 20, sectionHeight: 50, ""),
            items: [])
        self.items?.append(genericItem)
        self.tableView = GenericTableView(
            frame: tableViewContainer.bounds,
            items: self.items ?? [], tableViewStyle: .plain,
            isAllSelected: true)
        self.tableView?.cellForRowAt.sink(receiveValue: { item, cell in
            if let item = item as? Orange, let cell = cell as? OrangeTableViewCell {
                cell.label.text = item.title
            } else if let item = item as? Blue, let cell = cell as? BlueTableViewCell {
                cell.label.text = item.title
            }
        }).store(in: &cancellableBag)
        self.tableView?.didSelectRowAt.sink(receiveValue: { _ in
        }).store(in: &cancellableBag)
        tableViewContainer.addSubview(self.tableView!)
    }
}
