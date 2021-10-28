//
//  URLRequest.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
import NetworkingAPI
 
public enum ApiRequests: Request {
    
    case users
    case comments(location: ParameterLocation? = nil, params: [String: String]? = nil)
    case createPost(location: ParameterLocation? = nil, params: [String: String]? = nil)
    
    public var scheme: SchemesInterface {
        switch self {
        case .users, .comments, .createPost:
            return Schemes.https
            
        }
    }
    public var baseURL: BaseUrlInterface {
        switch self {
        case .users, .comments, .createPost:
            return BaseURL.production
        }
    }
    public var path: PathInterface {
        switch self {
        case .users:
            return Path(for: .users)
        case .comments:
            return Path(for: .comments())
        case .createPost:
            return Path(for: .createPost())
        }
    }
    
    public var method: MethodsInterface {
        switch self {
        case .users, .comments:
            return HTTPMethod.get
        case  .createPost:
            return HTTPMethod.post
        }
    }
    
    public var parameters: RequestParamsInterface? {
       
        switch self {
        case .users:
            return nil
        case .comments(let loc, let params):
            guard loc != nil && params != nil else { return nil }
            return  RequestParams.init(location: loc ?? .url, params: params ?? [:])
        case .createPost(let loc, let params):
            guard loc != nil && params != nil else { return nil }
            return  RequestParams.init(location: loc ?? .body, params: params ?? [:])
        } 
    }
    
    public var headers: HeadersInterface {
        switch self {
        case .users, .comments, .createPost:
            return Headers.defaultHeaders
        }
    }
    
}
