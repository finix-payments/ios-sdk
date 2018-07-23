//
//  Controller.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public class Tokenizer {

    var httpClient : HttpClient
    var applicationsPath : String = "/applications/"
    var tokensPath : String = "/tokens"
    var path : String
    
    public init(host: String, applicationId: String) {
        path = applicationsPath + applicationId + tokensPath
        httpClient = HttpClient(hostFinixAPI: host)
    }
    
    public func createToken(cardNumber: String, paymentType : PaymentType, expirationMonth: Int, expirationYear: Int, completion:((Token?, Error?) -> Void)?) {
        // creating instrument to tokenize data
        var instrument = Instrument()
        instrument.type = PaymentType.PAYMENT_CARD
        // taking validations away from user
        if (!instrument.isExpDateValid(expirationMonth: expirationMonth, expirationYear: expirationYear)) {
            completion?(nil, SDKError.invalidExpiration)
            return
        }
        if (!instrument.isCardNumberValid(cardNumber: cardNumber)) {
            completion?(nil, SDKError.invalidCardNumber)
            return
        }
        var json:Data? = nil
        do {
            json = try self.encodeJSON(instrument)
        } catch {
            completion?(nil,error)
            return
        }
        
        httpClient.post(to: path, data: json!) { (data, error) in
            if let error = error {
                completion?(nil,error)
                return
            }
            if let data = data {
                do {
                    let response = try self.decodeJSON(Response.self, data: data)
                    if let errors = response._embedded?.errors {
                        for apiError:APIError in errors {
                            print(apiError.message)
                            completion?(nil,SDKError.invalidNumber)
                        }
                    }
                    if response.id != nil {
                        completion?(try self.decodeJSON(Token.self, data: data),nil)
                    }
                } catch {
                    completion?(nil, SDKError.invalidJSON)
                    
                }
            }
        }
    }
    
    func encodeJSON<T: Encodable>(_ encodable: T) throws -> Data? {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        encoder.dateEncodingStrategy = .formatted(formatter)
        return try encoder.encode(encodable)
    }
    
    func decodeJSON<T : Decodable>(_ type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(type.self, from: data)
    }

}
