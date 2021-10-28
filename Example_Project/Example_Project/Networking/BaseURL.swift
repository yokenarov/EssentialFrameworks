//
//  BaseUrl.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import NetworkingAPI

public enum BaseURL: BaseUrlInterface {
    case production
    public var baseUrl: String {
        switch self {
        case .production:
            return "jsonplaceholder.typicode.com"
        }
    }
}
 
