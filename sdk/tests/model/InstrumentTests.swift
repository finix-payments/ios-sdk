//
//  InstrumentTests.swift
//  sdk
//
//  Created by user on 4/12/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import sdk

class InstrumentTests: XCTestCase {
    
    var fixtureInstrument : Instrument! = nil
    let fixtureType = PaymentType.PAYMENT_CARD
    let fixtureNumber = "4957030420210454"
    let fixtureMonth = 12
    let fixtureYear = 2022
    let fixtureDateString = "2018-04-04T21:49:32.18Z"
    var fixtureDate : Date! = nil
    let finixAPI = PaymentsSDK(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.dateFormat
        fixtureDate = dateFormatter.date(from: fixtureDateString)
        fixtureInstrument = Instrument(type: PaymentType.PAYMENT_CARD, number: fixtureNumber, expiration_month: fixtureMonth, expiration_year: fixtureYear)
    }
    
    //Test the fixture instrument is instatiated correctly in setUp
    func testFixtureInstrument() {
        XCTAssertNotNil(fixtureInstrument)
        XCTAssertEqual(fixtureType, fixtureType)
        XCTAssertEqual(fixtureNumber, fixtureInstrument.number)
        XCTAssertEqual(fixtureMonth, fixtureInstrument.expiration_month)
        XCTAssertEqual(fixtureYear, fixtureInstrument.expiration_year)
    }
    
    func testTokenizeInstrument() {
        let expectation = XCTestExpectation(description: "Tokenize payment instrument")
        let finixAPI = PaymentsSDK(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
        finixAPI.tokenize(instrument: fixtureInstrument) { (token,error) in
            if let token = token {
                XCTAssertNotNil(token.id)
                XCTAssertNotNil(token.fingerprint)
                XCTAssertNotNil(token.created_at)
                XCTAssertNotNil(token.updated_at)
                XCTAssertNotNil(token.currency)
                XCTAssertNotNil(token.instrument_type)
                XCTAssertNotNil(token.expires_at)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testEncodeDecodePaymentInstrument() {
        do {
            let jsonData = try finixAPI.encodeJSON(fixtureInstrument)
            let instrument = try finixAPI.decodeJSON(Instrument.self, data: jsonData)
            XCTAssertNotNil(instrument)
        } catch let error {
            print(error)
        }
    }
    
    func testInvalidNumber() {
        let expectation = XCTestExpectation(description: "Token is nil")
        let invalidNumberInstrument = Instrument(type: PaymentType.PAYMENT_CARD, number: "invalid_number", expiration_month: fixtureMonth, expiration_year: fixtureYear)
        finixAPI.tokenize(instrument: invalidNumberInstrument) { (token,error) in
            XCTAssertNil(token)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
