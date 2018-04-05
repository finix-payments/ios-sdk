//
//  client.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

class HttpClient : NSObject {
    
    static func post(jsonData: Data, completion:((Data?,Error?) -> Void)?) {
        var request = URLRequest(url: Config.baseURL)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(nil, responseError!)
                return
            }
            
            if let data = responseData {
                completion?(data, nil)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
}
