//
//  HttpClientError.swift
//  ios-sdk
//
//  Created by user on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public enum HttpClientError:Error {
    case invalidHost
    case noConnection
}

extension HttpClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidHost:
            return NSLocalizedString("Host is invalid", comment: "Host is invalid.")
        case .noConnection:
            return NSLocalizedString("Could not connect to server", comment: "Could not connect to server.")
        }
    }
}
