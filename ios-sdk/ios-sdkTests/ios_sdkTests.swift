//
//  ios_sdkTests.swift
//  ios-sdkTests
//
//  Created by user on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import XCTest
@testable import ios_sdk

class ios_sdkTests: XCTestCase {
    
    var fixtureInstrument : Instrument! = nil
    let fixtureType = "PAYMENT_CARD"
    let fixtureNumber = "4957030420210454"
    let fixtureMonth = 12
    let fixtureYear = 2022
    let fixtureDateString = "2018-04-04T21:49:32.18Z"
    var fixtureDate : Date! = nil
    var fixtureToken : Token! = nil
    let fixtureTokenId = "TK2q97hpcG9aNnHY82Dnd398"
    let fixtureTokenFingerprint = "FPR-549349958"
    let fixtureTokenCurrency = "USD"
    let fixtureTokenJSON = "{\"id\" : \"TK2q97hpcG9aNnHY82Dnd398\",\"fingerprint\" : \"FPR-549349958\",\"created_at\" : \"2018-04-04T22:23:41.84Z\",\"updated_at\" : \"2018-04-04T22:23:41.84Z\",\"instrument_type\" : \"PAYMENT_CARD\",\"expires_at\" : \"2018-04-05T22:23:41.84Z\",\"currency\" : \"USD\"}"
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.dateFormat
        fixtureDate = dateFormatter.date(from: fixtureDateString)
        fixtureInstrument = Instrument(type: fixtureType, number: fixtureNumber, expiration_month: fixtureMonth, expiration_year: fixtureYear)
        fixtureToken = Token(id: fixtureTokenId, fingerprint: fixtureTokenFingerprint, created_at: fixtureDate, updated_at: fixtureDate, instrument_type: fixtureType, expires_at: fixtureDate, currency: fixtureTokenCurrency)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Test the fixture instrument is instatiated correctly in setUp
    func testFixtureInstrument() {
        XCTAssertNotNil(fixtureInstrument)
        XCTAssertEqual(fixtureType, fixtureInstrument.type)
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
        Controller.tokenize(instrument: fixtureInstrument) { (token, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else if let token = token {
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
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEncodeDecodePaymentInstrument() {
        do {
            let jsonData = try Controller.encodeJSON(fixtureToken)
            let instrument = try Controller.decodeJSON(Token.self, data: jsonData)
            XCTAssertNotNil(instrument)
        } catch let error {
            print(error)
        }
    }
    
    func testDecodeJSON() {
        do {
            let token = try Controller.decodeJSON(Token.self, data: fixtureTokenJSON.data(using: .utf8)!)
            XCTAssertNotNil(token)
            XCTAssertEqual(fixtureTokenId, token.id)
            XCTAssertEqual(fixtureTokenFingerprint, token.fingerprint)
        } catch let error {
            print(error)
        }
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
