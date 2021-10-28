//
//  Schemes.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import NetworkingAPI
public enum Schemes: SchemesInterface {
    case http
    case https
    
    public var scheme: String {
        switch self {
        case .https: return "https"
        case .http: return "http"
        }
    }
    
}
