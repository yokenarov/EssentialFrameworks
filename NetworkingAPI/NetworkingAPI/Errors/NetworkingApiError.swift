//
//  NetworkingApiError.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation

enum NetworkingAPIError: Error {
case jsonParsingError(error: Error)
    case badUrl
}
