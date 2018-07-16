//
//  Instrument.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct Instrument: Codable {
    var type : PaymentType?
    var number : String?
    var security_code : String?
    var expiration_month : Int?
    var expiration_year : Int?
    var name : String?
    var address : Address?
    var tags : [String:String]?
    
    init() {
        
    }
    
    mutating func isExpDateValid(expMonth: Int, expYear: Int) -> Bool {
        let validMonth = expMonth > 0 && expMonth < 13
        //1950 is the year the first credit card was issued
        let validYear = expYear > 1950 && expYear < 2100
        if (validMonth && validYear) {
            self.expiration_month = expMonth
            self.expiration_year = expYear
            return true
        }
        return false
    }
    
    mutating func isCardNumberValid(cardNumber: String) -> Bool {
        if ((cardNumber.count > 19) || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardNumber))) {
            return false
        }
        self.number = cardNumber
        return true
    }
}
