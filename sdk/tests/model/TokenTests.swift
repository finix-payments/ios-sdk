//
//  TokenTests.swift
//  sdk
//
//  Created by Matt Sommer on 4/12/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import XCTest
@testable import ios_sdk

class TokenTests: XCTestCase {
    
    var fixtureToken : Token! = nil
    let fixtureTokenId = "TK2q97hpcG9aNnHY82Dnd398"
    let fixtureTokenFingerprint = "FPR-549349958"
    let fixtureTokenCurrency = "USD"
    let fixtureTokenInstrumentType = PaymentType.PAYMENT_CARD
    var fixtureDate : Date! = nil
    let fixtureDateString = "2018-04-04T21:49:32.18Z"
    let finixAPI = FinixAPI(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    let fixtureTokenJSON = "{\"id\" : \"TK2q97hpcG9aNnHY82Dnd398\",\"fingerprint\" : \"FPR-549349958\",\"created_at\" : \"2018-04-04T22:23:41.84Z\",\"updated_at\" : \"2018-04-04T22:23:41.84Z\",\"instrument_type\" : \"PAYMENT_CARD\",\"expires_at\" : \"2018-04-05T22:23:41.84Z\",\"currency\" : \"USD\"}"
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.dateFormat
        fixtureDate = dateFormatter.date(from: fixtureDateString)
        fixtureToken = Token(id: fixtureTokenId, fingerprint: fixtureTokenFingerprint, created_at: fixtureDate, updated_at: fixtureDate, instrument_type: fixtureTokenInstrumentType, expires_at: fixtureDate, currency: fixtureTokenCurrency)
    }
    
    //Test the fixture token is instatiated correctly in setUp
    func testFixtureToken() {
        XCTAssertNotNil(fixtureToken)
        XCTAssertEqual(fixtureTokenId, fixtureToken.id)
        XCTAssertEqual(fixtureTokenFingerprint, fixtureToken.fingerprint)
        XCTAssertEqual(fixtureTokenCurrency, fixtureToken.currency)
    }
    
    func testDecodeJSON() {
        do {
            let token = try finixAPI.decodeJSON(Token.self, data: fixtureTokenJSON.data(using: .utf8)!)
            XCTAssertNotNil(token)
            XCTAssertEqual(fixtureTokenId, token.id)
            XCTAssertEqual(fixtureTokenFingerprint, token.fingerprint)
        } catch let error {
            print(error)
        }
    }
}
