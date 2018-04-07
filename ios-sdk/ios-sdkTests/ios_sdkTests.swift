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
    
    var fixtureInstrument : Instrument! = nil
    let fixtureType = PaymentType.PAYMENT_CARD
    let fixtureNumber = "4957030420210454"
    let fixtureMonth = 12
    let fixtureYear = 2022
    let fixtureDateString = "2018-04-04T21:49:32.18Z"
    var fixtureDate : Date! = nil
    var fixtureToken : Token! = nil
    let fixtureTokenId = "TK2q97hpcG9aNnHY82Dnd398"
    let fixtureTokenFingerprint = "FPR-549349958"
    let fixtureTokenCurrency = "USD"
    let finixAPI = FinixAPI(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    let fixtureTokenJSON = "{\"id\" : \"TK2q97hpcG9aNnHY82Dnd398\",\"fingerprint\" : \"FPR-549349958\",\"created_at\" : \"2018-04-04T22:23:41.84Z\",\"updated_at\" : \"2018-04-04T22:23:41.84Z\",\"instrument_type\" : \"PAYMENT_CARD\",\"expires_at\" : \"2018-04-05T22:23:41.84Z\",\"currency\" : \"USD\"}"
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.dateFormat
        fixtureDate = dateFormatter.date(from: fixtureDateString)
        fixtureInstrument = Instrument(type: PaymentType.PAYMENT_CARD, number: fixtureNumber, expiration_month: fixtureMonth, expiration_year: fixtureYear)
        fixtureToken = Token(id: fixtureTokenId, fingerprint: fixtureTokenFingerprint, created_at: fixtureDate, updated_at: fixtureDate, instrument_type: fixtureType, expires_at: fixtureDate, currency: fixtureTokenCurrency)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Test the fixture instrument is instatiated correctly in setUp
    func testFixtureInstrument() {
        XCTAssertNotNil(fixtureInstrument)
        XCTAssertEqual(fixtureType, fixtureType)
        XCTAssertEqual(fixtureNumber, fixtureInstrument.number)
        XCTAssertEqual(fixtureMonth, fixtureInstrument.expiration_month)
        XCTAssertEqual(fixtureYear, fixtureInstrument.expiration_year)
    }
    
    //Test the fixture token is instatiated correctly in setUp
    func testFixtureToken() {
        XCTAssertNotNil(fixtureToken)
        XCTAssertEqual(fixtureTokenId, fixtureToken.id)
        XCTAssertEqual(fixtureTokenFingerprint, fixtureToken.fingerprint)
        XCTAssertEqual(fixtureTokenCurrency, fixtureToken.currency)
    }
    
    func testTokenizeInstrument() {
        let expectation = XCTestExpectation(description: "Tokenize payment instrument")
        let finixAPI = FinixAPI(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
        do {
            try finixAPI.tokenize(instrument: fixtureInstrument) { (token,error) in
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
        } catch {
            fatalError(error.localizedDescription)
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
//    func testEncodeDecodePaymentInstrument() {
//        do {
//            let jsonData = try FinixAPI.encodeJSON(fixtureToken)
//            let instrument = try FinixAPI.decodeJSON(Token.self, data: jsonData)
//            XCTAssertNotNil(instrument)
//        } catch let error {
//            print(error)
//        }
//    }
//
//    func testDecodeJSON() {
//        do {
//            let token = try FinixAPI.decodeJSON(Token.self, data: fixtureTokenJSON.data(using: .utf8)!)
//            XCTAssertNotNil(token)
//            XCTAssertEqual(fixtureTokenId, token.id)
//            XCTAssertEqual(fixtureTokenFingerprint, token.fingerprint)
//        } catch let error {
//            print(error)
//        }
//    }
    
    func testInvalidURL() {
        let finixAPI = FinixAPI(host: "", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    }
    
    func testInvalidNumber() {
        let expectation = XCTestExpectation(description: "Token is nil")
        let invalidNumberInstrument = Instrument(type: PaymentType.PAYMENT_CARD, number: "invalid_number", expiration_month: fixtureMonth, expiration_year: fixtureYear)

        do {
            try finixAPI.tokenize(instrument: invalidNumberInstrument) { (token,error) in
                XCTAssertNil(token)
                expectation.fulfill()
            }
        } catch SDKError.invalidNumber {
            print("Invalid instrument number")
        } catch {
            print("Unknown error")
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDateFormatter() {
        let testString = "2018-04-04T23:31:10.85Z"
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        let date = formatter.date(from: testString)
        XCTAssertNotNil(date)
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
}
