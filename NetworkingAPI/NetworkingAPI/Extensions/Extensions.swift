//
//  Extensions.swift
//  NetworkingAPI
//
//  Created by Jordan Kenarov on 24.10.21.
//

import Foundation
extension Dictionary {
    func percentEncoded() -> Data? {
        return compactMap({ (key, value) -> String in
            return "\(key)=\(value as! String)" // ad as? String if it doesnt work...
        }).joined(separator: "&").data(using: .utf8)
    }
}
