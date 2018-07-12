//
//  client.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

class HttpClient : NSObject {
    
    private var urlComponents = URLComponents()

    init(hostFinixAPI: String) {
        urlComponents.scheme = "https"
        urlComponents.host = hostFinixAPI
    }
    
    func post(to: String, data: Data, completion: ((Data?,Error?) -> Void)?) {
        urlComponents.path = to
        guard let url = urlComponents.url else {
            completion?(nil, SDKError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(nil, responseError)
                return
            }
            if let data = responseData {
                completion?(data, nil)
            }
        }
        task.resume()
    }
}
