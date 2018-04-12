//
//  ios_sdkTests.swift
//  ios-sdkTests
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import XCTest
@testable import ios_sdk

class ios_sdkTests: XCTestCase {

    func testInvalidURL() {
        let expectation = XCTestExpectation(description: "Invalid host")
        let finixAPI = FinixAPI(host: "", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
        finixAPI.tokenize(instrument: Instrument(type: PaymentType.PAYMENT_CARD, number: "123", expiration_month: 12, expiration_year: 2021)) { (token,error) in
            XCTAssertNil(token)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? HttpClientError, HttpClientError.noConnection)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDateFormatter() {
        let testString = "2018-04-04T23:31:10.85Z"
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        let date = formatter.date(from: testString)
        XCTAssertNotNil(date)
    }

}
