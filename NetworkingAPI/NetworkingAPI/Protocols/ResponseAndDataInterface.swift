//
//  ResponseAndDataInterface.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation
public protocol ResponseAndDataInterface {
    var response: URLResponse { get set }
    var data:     Data        { get set }
    init (response: URLResponse, data: Data)
    func printResponseStatus(file: String, function: String, line: Int)
}
