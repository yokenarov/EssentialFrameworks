//
//  ExtensionResponseAndDataInterface.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation
extension ResponseAndDataInterface {
    public var asResponseAndData: ResponseAndData {
      return (self as? ResponseAndData) ?? ResponseAndData(response: URLResponse(), data: Data())
    }
}
