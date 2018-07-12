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
        self.type = PaymentType.PAYMENT_CARD
    }
    
    mutating func isExpDateValid(expDate: String) -> Bool {
        let expirationPredicate = NSPredicate(format:"SELF MATCHES %@", "^[0-9]{2}\\/[0-9]{4}")
        if (expirationPredicate.evaluate(with: expDate)) {
            self.expiration_month = Int(String((expDate.prefix(2))))
            self.expiration_year = Int(String((expDate.suffix(4))))
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
