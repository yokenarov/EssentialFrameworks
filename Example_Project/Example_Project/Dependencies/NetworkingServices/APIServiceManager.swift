//
//  APIManager.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
import NetworkingAPI
import SwiftyDependency
import GenericViews
import Combine
class ApiManager: Dependency, CancellableBagProvider {
    var cancellableBag = Set<AnyCancellable>()
    func usersService() -> ApiRequests {
        return ApiRequests.users
    }
    func creatingAPostService(location: ParameterLocation?, params: [String: String]?) -> ApiRequests {
        return ApiRequests.createPost(location: location, params: params)
    }
    func commentsService(location: ParameterLocation?, params: [String: String]?) -> ApiRequests {
        return ApiRequests.comments(location: location, params: params)
    }
    func loadRequestWithClosure(completion: @escaping (GenericSectionWithItems) -> Void) {
        let genericTableViewItemWithSection  = GenericSectionWithItems(
            sectionLableBuilder: SectionLableBuilder(sectiontext: "", fontSize: 20, sectionHeight: 50, ""),
            items: [])
        ApiCaller.shared.makeURLRequestWithClosure(
            for: creatingAPostService(location: .body,
                                                 params: ["title": "foo", "body": "bar", "userId": "1"]),
               with: Comment.self) { decodedResponse, responseAndData in
                   responseAndData?.printResponseStatus(file: #file, function: #function, line: #line)
                   guard decodedResponse != nil else {
                       print(NetworkingAPIError.nilData)
                       return
                   }
                   let blue = Blue()
                   blue.title = decodedResponse?.title ?? ""
                   genericTableViewItemWithSection.items.append(blue)
                   completion(genericTableViewItemWithSection)
               }
    }
    // MARK: - PublisherMethod
    func loadRequestWithPublisher() -> AnyPublisher<[User], Never> {
        let publisher = ApiCaller.shared.makeURLRequesWithPublisher(for: usersService(),
                                                                       cancellableBagProvider: self)
            .printNetworkResponseInfo(file: #file, function: #function, line: #line)
            .tryMap(\.data)
            .receive(on: RunLoop.main, options: nil)
            .filter({ item in
                return !item.isEmpty
            })
            .decode(type: Array<User>.self, decoder: JSONDecoder())
            .map({ arr -> [User] in
                return arr
            })
            .assertNoFailure()
            .eraseToAnyPublisher()
        return publisher
    }
    deinit {
        print("Sucessfuly deinitialized ExampleViewModel. No memory leaks!")
    }
    // MARK: - MultiThreadedMethod
    func loadRequestWithMultiThreaded(completion: @escaping ([GenericModelType]) -> Void) {
        ApiCaller.shared.makeConcurrentCallWithClosures(
            concurrentRequests: [usersService(),
                                 creatingAPostService(
                                    location: .body,
                                    params: ["title": "foo", "body": "bar", "userId": "1"])],
            qos: .userInitiated, attributes: .concurrent) { arrayOfTuples in
                let jsonDecoder = JSONDecoder()
                var arrayOfUsers: [User]?
                var post: Post?
                var arrayOfGenericModelType = [GenericModelType]()
                for arrayOfTuple in arrayOfTuples {
                    switch arrayOfTuple.0 {
                    case 0:
                        arrayOfTuple.1.printResponseStatus(file: #file, function: #function, line: #line)
                        do {
                            arrayOfUsers = try jsonDecoder.decode([User].self, from: arrayOfTuple.1.data)
                            arrayOfUsers?.forEach({ user in
                                let blue = Blue()
                                blue.title = "User: \(user.name ?? "")"
                                arrayOfGenericModelType.append(blue)
                            })
                        } catch {
                            print(error)
                            arrayOfUsers = []
                        }
                    case 1:
                        arrayOfTuple.1.printResponseStatus(file: #file, function: #function, line: #line)
                        do {
                            post = try jsonDecoder.decode(Post.self, from: arrayOfTuple.1.data)
                            let orange = Orange()
                            orange.title = "Post: \(post?.id ?? 0)"
                            arrayOfGenericModelType.append(orange)
                        } catch {
                            print(error)
                            post = Post()
                        }
                    default: break
                    }
                }
                completion(arrayOfGenericModelType)
            }
    }
}
