//
//  ExtensionPublisher.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation
import Combine

extension Publisher where Output == ResponseAndData {
    
    public func printNetworkResponseInfo(file: String, function: String, line: Int,_ ofItem: ((Output) -> Void)? = nil)  ->  Publishers.Map<Self, Output> {
        map { item in
            item.printResponseStatus(file: file, function: function, line: line)
            return  item
        }
    }
    
}
