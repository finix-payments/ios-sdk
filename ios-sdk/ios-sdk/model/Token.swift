//
//  Token.swift
//  ios-sdk
//
//  Created by user on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct Token:Codable {
    var id : String
    var fingerprint : String
    var created_at : Date
    var updated_at : Date
    var instrument_type : String
    var expires_at : Date
    var currency : String
}
