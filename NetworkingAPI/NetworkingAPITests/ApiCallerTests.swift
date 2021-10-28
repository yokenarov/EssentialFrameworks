//
//  ApiCallerTests.swift
//  NetworkingAPITests
//
//  Created by Jordan Kenarov on 28.10.21.
//
import XCTest
import Foundation
import Combine
@testable import NetworkingAPI

class ApiCallerTest: XCTestCase, CancellableBagProvider, DataTaskWithDelegate {
    var cancellableBag = Set<AnyCancellable>() 
    var sut: APICallerInterface!
    var expectedStatusCode = 200
    var receivedStatusCode: Int?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ApiCaller()
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPublisher() {
        sut.makeURLRequesWithPublisher(for: TestApiRequests.test, cancellableBagProvider: self)
            .sink { _ in }
           receiveValue: { [weak self] responseAndData in
              self?.expectedStatusCode = (responseAndData.response as? HTTPURLResponse)!.statusCode
               XCTAssertEqual(self?.expectedStatusCode, self?.receivedStatusCode)
           }.store(in: &cancellableBag)
    }
    
    func testClosure() {
        sut.makeURLRequestWithClosure(for: TestApiRequests.test, with: Array<User>.self) {[weak self] _, responseAndData in
            self?.receivedStatusCode = (responseAndData?.response as! HTTPURLResponse).statusCode
            XCTAssertEqual(self?.expectedStatusCode, self?.receivedStatusCode)
        }
    }
    
    func testDelegate() {
        sut.makeURLRequestWithDelegate(for: TestApiRequests.test, with: Array<User>.self, dataTaskDelegateImplementor: self)
    }
    func resultFromURLRequestWithDelegate(model: Codable?, responseAndData: ResponseAndData?) {
        self.receivedStatusCode = responseAndData?.statusCode
        XCTAssertEqual(self.expectedStatusCode, self.receivedStatusCode)
    }
}
