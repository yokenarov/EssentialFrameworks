//
//  Protocols.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import Combine

public protocol Request {
    var scheme:     SchemesInterface        { get }
    var baseURL:    BaseUrlInterface        { get }
    var path:       PathInterface           { get }
    var method:     MethodsInterface        { get }
    var parameters: RequestParamsInterface? { get }
    var headers:    HeadersInterface?       { get }
    var dataType:   DataType                { get }
}
public protocol SchemesInterface {
    var scheme: String  { get }
}
public protocol BaseUrlInterface {
    var baseUrl: String  { get }
}
public protocol PathInterface  {
    var path: String { get }
}
public protocol MethodsInterface {
    var method: String { get }
}
public protocol RequestParamsInterface {
    var params: (ParameterLocation, [String: String])? { get }
}
public protocol HeadersInterface  {}


public extension Request {
    var fullUrl: String {
        return scheme.scheme+baseURL.baseUrl
    }
    var fullRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.scheme
        urlComponents.host = baseURL.baseUrl
        urlComponents.path = path.path
        var bodyData: Data?
        if let location = parameters?.params?.0, let params = parameters?.params?.1 {
            var components = [URLQueryItem]()
            switch location {
            case .body:
                guard method.method == "POST" || method.method == "PUT" else {
                    print("You are trying encode a httpBody and your method is not POST or PUT. No body will be encoded.")
                    break }
                let encoder = JSONEncoder()
                bodyData = try! encoder.encode(params)
                
            case .url:
                params.forEach { key, value in
                    let component = URLQueryItem(name: key, value: value)
                    components.append(component)
                }
                urlComponents.queryItems = components
            }
        }
        guard let url = urlComponents.url else {
            print("Could not make a url. Check your custom implementation of the Request protocol.")
            return  URLRequest(url: URL(string: fullUrl)!)
        }
        var request = URLRequest(url: url)
        request.httpBody = bodyData ?? Data()
        request.httpMethod = method.method 
        return request
    }
}
