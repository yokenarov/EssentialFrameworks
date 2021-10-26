//
//  ExtensionApiCallerInterface.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 26.10.21.
//

import Foundation
import Combine

extension APICallerInterface {
    /**
     A function that returns starts a data task publisher with a custom object, conforiming to the Request protocol and returns an Anypublisher with custom output type with the response and the raw data from the response.

        - Parameters:
            - request: This parrameter accepts a type that conforms to the protocl Request. You will have to provide your own custom implementation of that type. See more on the Request protocol definition.

        - Returns:
    */
    public func makeURLRequestPublisher(for request:  Request) -> AnyPublisher<ResponseAndData, NetworkingAPIError> {
       var unwrappedRequest: URLRequest?
       
        do { try unwrappedRequest = request.fullRequest } catch {
            print(error)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
       
       let publisher = URLSession.shared.dataTaskPublisher(for: unwrappedRequest!)
            .tryMap() { incomingURLResponse -> ResponseAndData in
                let responseAndData = ResponseAndData(response: incomingURLResponse.response, data: incomingURLResponse.data)
                return responseAndData
           } 
           .mapError({ error -> NetworkingAPIError in
               return NetworkingAPIError.badRequest(error: error.localizedDescription)
           })
           .eraseToAnyPublisher()
       return publisher
    }
}
