//
//  Address.swift
//  ios-sdk
//
//  Created by user on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

struct Address: Codable {
    var line1 : String
    var line2 : String
    var city : String
    var region : String
    var postal_code : String
    var country : String
}
