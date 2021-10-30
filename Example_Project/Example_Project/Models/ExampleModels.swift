//
//  ExampleModels.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 28.10.21.
//

import Foundation
public struct User: Codable {
    public var id: Int?
    public var name: String?
}
public struct Post: Codable {
    public var id: Int?
    public var name: String?
}

public struct Comment: Codable {
    var title: String?
    var body: String?
    var userId: String?
}
enum PrefferedStyle {
    case publisher
    case closure
    case delegate
    case multiThread
}
