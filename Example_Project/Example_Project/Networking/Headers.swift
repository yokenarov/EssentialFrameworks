//
//  Headers.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 26.10.21.
//

import Foundation
import NetworkingAPI
enum Headers: HeadersInterface {
case defaultHeaders
case defaultHeadersWith(additionalHeaders: [String:String])
case createNewHeaders(newHeaders: [String:String])
    var defaultHeaders: [String: String] {
        get {["Content-Type":"application/json"]}
    } 
    var headers: [String : String] {
        switch self {
        case .defaultHeaders:
            return ["Content-Type":"application/json"]
        case .defaultHeadersWith(additionalHeaders: let additionalHeaders):
            return combineHeaders(additionalHeaders: additionalHeaders)
        case .createNewHeaders(newHeaders: let newHeaders):
            return newHeaders
        }
    }
}
