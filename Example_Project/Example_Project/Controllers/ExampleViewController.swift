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
    var cancellableBag = Set<AnyCancellable>()
    var tableView: GenericTableView!
    var items = [GenericSectionWithItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        switch ApiCaller.shared.preferedStyle {
        case .publisher:
            loadTranslationsWithPublisher()
        case .closure:
            loadTranslationsWithClosure()
        case .delegate:
            loadTranslationsWithDelegate()
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
            guard let item = item as? Blue else { return }
            guard let cell = cell as? BlueTableViewCell else { return }
            cell.label.text = item.title
        }).store(in: &cancellableBag)
        tableView.didSelectRowAt.sink(receiveValue: { _ in
        }).store(in: &cancellableBag)
        self.tableViewContainer.addSubview(tableView)
    }
    // MARK: - ClosureMethod
    func loadTranslationsWithClosure() {
        ApiCaller.shared.makeURLRequestWithClosure(
            for: ApiRequests.createPost(location: .body, params: ["title": "foo", "body": "bar", "userId": "1"]),
            with: Comment.self) { decodedResponse, responseAndData in
            responseAndData?.printResponseStatus(file: #file, function: #function, line: #line)
            guard decodedResponse != nil else {
                print(NetworkingAPIError.nilData)
                return
            }
            let blue = Blue()
            blue.title = decodedResponse?.title ?? ""
            self.items[0].items.append(blue)
            self.tableView.reloadData()
        }
    }
    // MARK: - PublisherMethod
    func loadTranslationsWithPublisher() {
        ApiCaller.shared.makeURLRequesWithPublisher(for: ApiRequests.users, cancellableBagProvider: self)
            .printNetworkResponseInfo(file: #file, function: #function, line: #line)
            .tryMap(\.data)
            .receive(on: RunLoop.main, options: nil)
            .filter({ item in
                return !item.isEmpty
            })
            .decode(type: Array<User>.self, decoder: JSONDecoder())
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    self.tableView.reloadData()
                case .failure(let error):
                    AlertPresenter.shared.presentAlert(viewController: self, errorMessage: error.localizedDescription)
                    print(error)
                }
            }
    receiveValue: { users in
        users.forEach { user in
            let blue = Blue()
            blue.title = user.name ?? ""
            self.items[0].items.append(blue)
        }
    }.store(in: &cancellableBag)
    }
    // MARK: - DelegateMethod
    func loadTranslationsWithDelegate() {
        ApiCaller.shared.makeURLRequestWithDelegate(
            for: ApiRequests.comments(location: .url, params: ["postId": "1"]),
            with: Array<Post>.self, dataTaskDelegateImplementor: self)
    }
    func resultFromURLRequestWithDelegate(model: Codable?, responseAndData: ResponseAndData?) {
        responseAndData?.printResponseStatus(file: #file, function: #function, line: #line)
        DispatchQueue.main.async {
            guard let unwrappedPosts = model as?  [Post] else { return }
            unwrappedPosts.forEach { post in
            let blue = Blue()
            blue.title = post.name ?? ""
            self.items[0].items.append(blue)
            self.tableView.reloadData()
            }
        }
    }
    deinit {
        print("Sucessfuly deinitialized. No memory leaks!")
    }
}
