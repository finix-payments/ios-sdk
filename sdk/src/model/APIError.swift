//
//  Error.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct APIError: Codable {
    var logref : String
    var message : String
    var code : String
    var field : String
}
