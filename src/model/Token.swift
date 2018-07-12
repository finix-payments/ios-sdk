//
//  Token.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public struct Token: Codable {
    public var id : String
    public var fingerprint : String
    public var created_at : Date
    public var updated_at : Date
    public var instrument_type : PaymentType
    public var expires_at : Date
    public var currency : String
}
