//
//  NetworkAPICallerInterface.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import Combine
public protocol APICallerInterface {
    func makeURLRequestPublisher(for request:  Request) -> AnyPublisher<Data, RequestError>  
    func parseDataFromRequest()
}
 
public enum RequestError: Error {
    case badRequest(error: String)
}
