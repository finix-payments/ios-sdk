//
//  ViewController.swift
//  ios-example-sdk-ui
//
//  Created by user on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import UIKit
import ios_sdk

class ViewController: UITableViewController {
    
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblTokenId: UILabel!
    @IBOutlet weak var lblTokenFingerprint: UILabel!
    @IBOutlet weak var lblTokenCreated: UILabel!
    @IBOutlet weak var lblTokenUpdated: UILabel!
    @IBOutlet weak var lblTokenType: UILabel!
    @IBOutlet weak var lblTokenExpires: UILabel!
    @IBOutlet weak var lblTokenCurrency: UILabel!
    
    var token : Token? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitBtn(_ sender: Any) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let instrument = Instrument(type: "PAYMENT_CARD", number: txtNumber.text!, expiration_month: 12, expiration_year: 2021)
        Controller.tokenize(instrument: instrument) { (token, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else if let token = token {
                DispatchQueue.main.async {
                    self.lblTokenId.text = "ID: " + token.id
                    self.lblTokenFingerprint.text = "Fingerprint: " + token.fingerprint
                    self.lblTokenCreated.text = "Created: " + formatter.string(from: token.created_at)
                    self.lblTokenUpdated.text = "Updated: " + formatter.string(from: token.updated_at)
                    self.lblTokenType.text = "Type: " + token.instrument_type
                    self.lblTokenExpires.text = "Expires: " + formatter.string(from: token.expires_at)
                    self.lblTokenCurrency.text = "Currency: " + token.currency
                }
            }
        }
    }
    
}
