//
//  client.swift
//  ios-sdk
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import Foundation

class Client : NSObject {
    
    func tokenize(completion: ((Error?) -> Void)?) {
        let encoder = JSONEncoder()

        var request = URLRequest(url: URL(string: "https://api-staging.finix.io/applications/AP2kL9QSWYJGpuAtYYnK5cZY/tokens")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        do {
            let instrument = Instrument(type: "PAYMENT_CARD", number: "4957030420210454", expiration_month: 12, expiration_year: 2020)
            let jsonData = try encoder.encode(instrument)
            request.httpBody = jsonData
        } catch {
            completion?(error)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
