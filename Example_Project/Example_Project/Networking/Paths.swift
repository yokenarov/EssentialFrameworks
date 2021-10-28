//
//  Paths.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import NetworkingAPI

struct Path: PathInterface {
    private var apis: ApiRequests
    init(for apis: ApiRequests) {
        self.apis = apis
    }
        var path: String {
        switch apis {
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        case .createPost:
            return "/posts"
        }
    }
}
