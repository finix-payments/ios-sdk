//
//  Response.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/6/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct Response:Codable {
    public var id : String?
    var total: Int?
    var _embedded: Embedded?
}
