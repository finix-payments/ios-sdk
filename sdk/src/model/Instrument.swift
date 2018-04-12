//
//  Instrument.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public struct Instrument: Codable {
    var type : PaymentType
    var number : String
    var security_code : String?
    var expiration_month : Int
    var expiration_year : Int
    var name : String?
    var address : Address?
    var tags : [String:String]?
    
    public init(type:PaymentType, number:String, expiration_month:Int, expiration_year:Int) {
        self.type = type
        self.number = number
        self.expiration_month = expiration_month
        self.expiration_year = expiration_year
    }
    
}
