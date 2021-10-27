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
 
    */
    public func makeURLRequesWithPublisher(for request: Request,
                                        with providedResponseAndData: ResponseAndDataInterface? = ResponseAndData(response: URLResponse(), data: Data())) -> AnyPublisher<ResponseAndDataInterface, NetworkingAPIError> {
        var mutableResponseAndData = providedResponseAndData
        var unwrappedRequest: URLRequest?
       
        do { try unwrappedRequest = request.fullRequest } catch {
            print(error)
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
       
       let publisher = URLSession.shared.dataTaskPublisher(for: unwrappedRequest!)
            .tryMap() { incomingURLResponse -> ResponseAndDataInterface in
                    mutableResponseAndData?.response = incomingURLResponse.response
                    mutableResponseAndData?.data = incomingURLResponse.data
                    return mutableResponseAndData! 
           } 
           .mapError({ error -> NetworkingAPIError in
               return NetworkingAPIError.badRequest(error: error.localizedDescription)
           })
           .eraseToAnyPublisher()
       return publisher
    }
    /**
     A function that returns starts a URLSessionDataTask with a custom object, conforiming to the Request protocol and returns an escaping closure with custom output type with the response and the raw data from the response.

        - Parameters:
            - request: This parrameter accepts a type that conforms to the protocl Request. You will have to provide your own custom implementation of that type. See more on the Request protocol definition.
 
    */
   public func makeURLRequestWithClosure(for request: Request,
                                   with providedResponseAndData: ResponseAndDataInterface? = ResponseAndData(response: URLResponse(), data: Data()),
                                   withResponseAndData completion: @escaping (ResponseAndDataInterface) -> Void) {
        var mutableResponseAndData = providedResponseAndData
        var unwrappedRequest: URLRequest?
        do { try unwrappedRequest = request.fullRequest } catch { print(error) }
        URLSession.shared.dataTask(with: unwrappedRequest!) { data, response, error in
            guard error == nil else {
                print(NetworkingAPIError.networkError(error: "❌ A networking error occured \(error?.localizedDescription ?? "No error received"). Default Data() and URLResponse() will be returned."))
                DispatchQueue.main.async {
                completion(mutableResponseAndData!)
                }
                return
            }
            if data == nil {
                print(NetworkingAPIError.nilData(error: "❌ The incoming data is nil. A default Data() will be returned"))
            }else if response == nil {
                print(NetworkingAPIError.nilResponse(error: "❌ The incoming response is nil. A default URLResponse() will be returned"))
            }
            mutableResponseAndData?.response = response ?? URLResponse()
            mutableResponseAndData?.data = data ?? Data ()
            DispatchQueue.main.async {
            completion(mutableResponseAndData!)
            }
        }.resume()
    }
}
