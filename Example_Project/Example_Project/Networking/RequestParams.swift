//
//  RequestParams.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import NetworkingAPI
public struct RequestParams: RequestParamsInterface {
    init(location: ParameterLocation, params: [String: String]) {
        self.params = (location, params)
    }
   public var params: (ParameterLocation, [String : String])? 
    
}
