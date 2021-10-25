//
//  NetworkAPICallerInterface.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import Combine
public protocol APICallerInterface { //URLSession.DataTaskPublisher.Output
    func makeURLRequestPublisher(for request:  Request) -> AnyPublisher<ResponseAndData, RequestError>
    func parseDataFromRequest()
}
 
public enum RequestError: Error {
    case badRequest(error: String)
    case ImproperBody(error: String)
}
