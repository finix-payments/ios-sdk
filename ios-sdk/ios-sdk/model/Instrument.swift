//
//  Instrument.swift
//  ios-sdk
//
//  Created by user on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct Instrument: Codable {
    var type : String
    var number : String
    var expiration_month : Int
    var expiration_year : Int
}
