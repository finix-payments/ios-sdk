//
//  SDKError.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public enum SDKError:Error {
    case invalidURL
    case invalidNumber
    case invalidJSON
}

extension SDKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidNumber:
            return NSLocalizedString("Number is invalid", comment: "Number is invalid")
        case .invalidURL:
            return NSLocalizedString("URL is invalid", comment: "URL is invalid")
        case .invalidJSON:
            return NSLocalizedString("JSON is invalid", comment: "There was an issue parsing the JSON")
        }
    }
}
