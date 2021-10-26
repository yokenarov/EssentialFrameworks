//
//  ExtensionPublisher.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 25.10.21.
//

import Foundation
import Combine

extension Publisher where Output == ResponseAndData {
    /**
     An operator that prints a predifined status of the incoming response.
     
        - Parameters:
            - file:  points to the file in which the function is called. It would be enough to provide #file as a pameter here.
            - function:  points to the name of the function. It would be enough to provide #function as a pameter here.
            - lline:  points to the line in the file in which the function is called. It would be enough to provide #line as a pameter here.
        - Returns:
    */
    public func printNetworkResponseInfo(file: String, function: String, line: Int,_ ofItem: ((Output) -> Void)? = nil)  ->  Publishers.Map<Self, Output> {
        map { item in
            item.printResponseStatus(file: file, function: function, line: line)
            return  item
        }
    }

}
//extension Publisher where Output == ResponseAndDataInterface.Type {
//    var allClassesArray: [ResponseAndDataInterface.Type] {
//        get {
//            let object = NSObject()
//            return  object.allClasses { $0.compactMap { $0 as? ResponseAndDataInterface.Type } }
//        }
//    }
//    public func mapResponseAndDataInterfaceToSpecifcType(currentType: ResponseAndDataInterface.Type) ->  Publishers.Map<Self, Output> {
//        map { genericResponseItem in
//            var transformedItem: ResponseAndDataInterface.Type?
//            for item in allClassesArray {
//                if currentType == item {
//                    transformedItem = currentType
//                    return transformedItem!
//                }
//            }
//            return transformedItem!
//
//        }
//    }
//}
