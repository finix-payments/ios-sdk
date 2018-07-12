//
//  ios_sdkTests.swift
//  ios-sdkTests
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import XCTest
@testable import sdk

class ios_sdkTests: XCTestCase {

    func testInvalidURL() {
        let expectation = XCTestExpectation(description: "Invalid host")
        let paymentsSDK = PaymentsSDK(host: "", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
        do {
            try paymentsSDK.tokenize(instrument: Instrument(type: PaymentType.PAYMENT_CARD, number: "123", expiration_month: 12, expiration_year: 2021)) { (token,error) in
                XCTAssertNil(token)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        } catch {
            
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
