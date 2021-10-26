//
//  ExtensionResponseAndData.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 26.10.21.
//

import Foundation
extension ResponseAndDataInterface {
    public var asResponseAndData: ResponseAndData {
        return self as! ResponseAndData  
    }
    public func asCustomType(response: URLResponse, data: Data) ->  ResponseAndDataInterface {
        return Self(response: response, data: data)
    }
}
extension ResponseAndDataInterface  {
    func isEqualTo(other: ResponseAndDataInterface) -> Bool {
        return type(of: self) == type(of: other.self)
    }
    func isEqualToType(of other: ResponseAndDataInterface.Type) -> Bool {
        print(type(of: self) == type(of: other.self))
        return type(of: self) == type(of: other.self)
    }
}
 
