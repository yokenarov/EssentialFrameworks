//
//  ResponseAndData.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation

public struct ResponseAndData: ResponseAndDataInterface {
public var statusCode: Int?
public var url: String?
public var data: Data?
public init(response: URLResponse, data: Data) {  
         guard let response = response as? HTTPURLResponse else {
             print("Could not cast response as HTTPURLResponse.")
             return }
        self.statusCode = response.statusCode
        self.url = response.url?.absoluteString
        self.data = data
    }

    public func printResponseStatus(file: String, function: String, line: Int) {
        print("""
              ⏤⏤⏤⏤⏤⏤
              \(GetSourceOfString().forNetworkCall(file: file, function: function, line: line)) \n\(validateStatusCode) \(statusCode ?? 0) - \(url ?? "")
              """)
    }
    
    private var validateStatusCode: String {
        switch statusCode ?? 0 {
        case 200...300:
            return "✅"
        case 300...400:
            return "⚠️"
        case 400...600:
            return "❌"
        default: return "❌"
        }
        
    }
}
 
