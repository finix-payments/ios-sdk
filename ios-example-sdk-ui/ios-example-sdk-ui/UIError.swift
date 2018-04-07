//
//  UIError.swift
//  ios-example-sdk-ui
//
//  Created by user on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public enum UIError:Error {
    case invalidExpiration
}

extension UIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidExpiration:
            return NSLocalizedString("Invalid Expiration", comment: "Invalid expiration date, must be in format 04/2021")
        }
    }
}
