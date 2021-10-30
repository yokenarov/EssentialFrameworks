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
class ExampleViewController: UIViewController, CancellableBagProvider, DataTaskWithDelegate {
    @IBOutlet weak var tableViewContainer: UIView!
    var exampleModelView = ExampleModelView()
    var cancellableBag = Set<AnyCancellable>()
    var tableView: GenericTableView!
    var items = [GenericSectionWithItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        switch ApiCaller.shared.preferedStyle {
        case .publisher:
            loadTableviewWithPublisherData()
        case .closure:
            loadTableViewWithClosureData()
        case .delegate:
            loadTableViewWithDelegate()
        case .multiThread:
            exampleModelView.loadRequestWithMultiThreaded { genericItems in
                self.items[0].items = genericItems
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        guard self.tableViewContainer != nil else { return }
        guard self.tableView == nil else { return }
        let genericItem  = GenericSectionWithItems(
            sectionLableBuilder: SectionLableBuilder(sectiontext: "", fontSize: 20, sectionHeight: 50, ""),
            items: [])
        items.append(genericItem)
        tableView = GenericTableView(
            frame: tableViewContainer.bounds,
            items: items, tableViewStyle: .plain,
            isAllSelected: true)
        tableView.cellForRowAt.sink(receiveValue: { item, cell in
            if let item = item as? Orange, let cell = cell as? OrangeTableViewCell {
                cell.label.text = item.title
            } else if let item = item as? Blue, let cell = cell as? BlueTableViewCell {
                cell.label.text = item.title
            }
        }).store(in: &cancellableBag)
        tableView.didSelectRowAt.sink(receiveValue: { _ in
        }).store(in: &cancellableBag)
        self.tableViewContainer.addSubview(tableView)
    }
    func loadTableviewWithPublisherData() {
        exampleModelView.loadRequestWithPublisher()
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            } receiveValue: { [weak self] users in
                users.forEach { user in
                    let blue = Blue()
                    blue.title = user.name ?? ""
                    self?.items[0].items.append(blue)
                }
            }.store(in: &cancellableBag)
    }
    func loadTableViewWithClosureData() {
        exampleModelView.loadRequestWithClosure { [weak self] genericItem in
            self?.items[0].items = genericItem.items
            self?.tableView.reloadData()
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
                self.items[0].items.append(blue)
                self.tableView.reloadData()
            }
        }
    }
    deinit {
        print("Sucessfuly deinitialized ExampleViewController. No memory leaks!")
    }
}
