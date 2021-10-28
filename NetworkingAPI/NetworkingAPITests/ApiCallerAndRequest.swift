//
//  ApiCallerTest.swift
//  NetworkingAPITests
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
@testable import NetworkingAPI

class ApiCaller: APICallerInterface { }
enum TestApiRequests: Request {
    case test
    var scheme: SchemesInterface {
        switch self {
        case .test:
            return Schemes()
        }
    }
    
    var baseURL: BaseUrlInterface{
        switch self {
        case .test:
            return BaseUrl()
        }
    }
    
    var path: PathInterface{
        switch self {
        case .test:
            return Path()
        }
    }
    
    var method: MethodsInterface{
        switch self {
        case .test:
            return Methods()
        }
    }
    
    var parameters: RequestParamsInterface?{
        switch self {
        case .test:
            return RequestParams()
        }
    }
    
    var headers: HeadersInterface{
        switch self {
        case .test:
            return Headers()
        }
    }
    
    
}
struct Schemes: SchemesInterface  {
    var scheme: String = "https"
}
struct BaseUrl: BaseUrlInterface  {
    var baseUrl: String = "jsonplaceholder.typicode.com"
     
}
struct Path: PathInterface  {
    var path: String = "/users"
     
}
struct Methods: MethodsInterface  {
    var method: String = "GET"
}
struct RequestParams: RequestParamsInterface  {
    var params: (ParameterLocation, [String : String])?
}
struct Headers: HeadersInterface  {
    var defaultHeaders: [String : String] = [:]
    
    var headers: [String : String] = [:]
}
public struct User: Codable {
    public var id: Int?
    public var name: String?
}
