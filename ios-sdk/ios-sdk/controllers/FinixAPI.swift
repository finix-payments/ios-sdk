//
//  Controller.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/4/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

public class FinixAPI {

    var httpClient : HttpClient
    var applicationsPath : String = "/applications/"
    var tokensPath : String = "/tokens"
    var path : String
    
    public init(host: String, applicationId: String) {
        path = applicationsPath + applicationId + tokensPath
        httpClient = HttpClient(hostFinixAPI: host)
    }
    
    public func tokenize(instrument: Instrument, completion:((Token?, SDKError?) -> Void)?) {
        do {
            let jsonData = try self.encodeJSON(instrument)
            httpClient.post(path: self.path, jsonData: jsonData) { (data, error) in
                if let error = error {
                    print("Post Error:::" + error.localizedDescription)
                } else if let data = data {
                    do {
                        let response = try self.decodeJSON(Response.self, data: data)
                        if let errors = response._embedded?.errors {
                            for apiError:APIError in errors {
                                print(apiError.message)
                                completion?(nil,SDKError.invalidNumber)
                            }
                        }
                        if response.id != nil {
                            do {
                                completion?(try self.decodeJSON(Token.self, data: data),nil)
                            } catch {
                                
                            }
                        }
                    } catch let error {
                        print("Parse Error:::" + error.localizedDescription)
                    }
                }
            }
        } catch {
            print("Encode Error:::" + error.localizedDescription)
        }

    }
    
    func encodeJSON<T: Encodable>(_ encodable: T) throws -> Data {
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
