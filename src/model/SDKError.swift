//
//  SDKError.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

enum SDKError:Error {
    case invalidExpiration
    case invalidCardNumber
    case invalidURL
    case invalidNumber
    case invalidJSON
}

extension SDKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidExpiration:
            return NSLocalizedString("Invalid expiration date, must be in format mm/yyyy", comment: "Invalid Expiration")
        case .invalidCardNumber:
            return NSLocalizedString("Invalid card number", comment: "Invalid number")
        case .invalidNumber:
            return NSLocalizedString("Number is invalid", comment: "Number is invalid")
        case .invalidURL:
            return NSLocalizedString("URL is invalid", comment: "URL is invalid")
        case .invalidJSON:
            return NSLocalizedString("JSON is invalid", comment: "There was an issue parsing the JSON")
        }
    }
}
