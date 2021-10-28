//
//  RequestTest.swift
//  NetworkingAPITests
//
//  Created by Jordan Kenarov on 28.10.21.
//

import XCTest
@testable import NetworkingAPI

class NetworkRequestTest: XCTestCase {
    var sut: Request!
    var expectedUrl = "https://jsonplaceholder.typicode.com/users"
    var receivedURL: String?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TestApiRequests.test
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testUrlFormation() {
        let sutURL = sut.fullUrl
        XCTAssertEqual(expectedUrl, sutURL)
    }
}
