//
//  Controller.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public class Controller {
    
    public static func tokenize(instrument: Instrument, completion:((Token?,Error?) -> Void)?) {
        do {
            let jsonData = try self.encodeJSON(instrument)
            
            HttpClient.post(jsonData: jsonData) { (data, error) in
                if let error = error {
                    fatalError(error.localizedDescription)
                } else if let data = data {
                    do {
                        completion?(try self.decodeJSON(Token.self, data: data), nil)
                    } catch let error {
                        print(error)
                    }
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    static func encodeJSON<T: Encodable>(_ encodable: T) throws -> Data {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        encoder.dateEncodingStrategy = .formatted(formatter)
        return try encoder.encode(encodable)
    }
    
    static func decodeJSON<T : Decodable>(_ type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(type.self, from: data)
    }

}
