//
//  APIManager.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 30.10.21.
//

import Foundation
import NetworkingAPI
class ApiManager {
    func usersService() -> ApiRequests {
        return ApiRequests.users
    }
    func creatingAPostService(location: ParameterLocation?, params: [String: String]?) -> ApiRequests {
        return ApiRequests.createPost(location: location, params: params)
    }
    func commentsService(location: ParameterLocation?, params: [String: String]?) -> ApiRequests {
        return ApiRequests.comments(location: location, params: params)
    }
}
