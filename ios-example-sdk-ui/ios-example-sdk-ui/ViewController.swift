//
//  ViewController.swift
//  ios-example-sdk-ui
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import UIKit
import ios_sdk

class ViewController: UITableViewController {
    
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtExpiration: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var lblTokenId: UILabel!
    @IBOutlet weak var lblTokenFingerprint: UILabel!
    @IBOutlet weak var lblTokenCreated: UILabel!
    @IBOutlet weak var lblTokenUpdated: UILabel!
    @IBOutlet weak var lblTokenType: UILabel!
    @IBOutlet weak var lblTokenExpires: UILabel!
    @IBOutlet weak var lblTokenCurrency: UILabel!
    
    let finixTokenizeAPI = FinixAPI(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    let app : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitBtn(_ sender: Any) {
        do {
            let instrument = try buildInstrument()
            finixTokenizeAPI.tokenize(instrument: instrument) { (token, error) in
                if let token = token {
                    self.setView(token: token)
                } else if let error = error {
                    self.displayError(error: error)
                }
            }
        } catch {
            displayError(error: UIError.invalidExpiration)
        }
    }
    
    func buildInstrument() throws -> Instrument {
        let expirationFormat = "^[0-9]{2}\\/[0-9]{4}"
        let expirationPredicate = NSPredicate(format:"SELF MATCHES %@", expirationFormat)
        if expirationPredicate.evaluate(with: txtExpiration.text!) {
            return Instrument(type: PaymentType.PAYMENT_CARD, number: txtNumber.text!, expiration_month: 12, expiration_year: 2021)
        } else {
            throw UIError.invalidExpiration
        }
    }
    
    func setView(token: Token) {
        DispatchQueue.main.async {
            self.lblTokenId.text = "ID: " + token.id
            self.lblTokenFingerprint.text = "Fingerprint: " + token.fingerprint
            self.lblTokenCreated.text = "Created: " + self.app.dateFormatter.string(from: token.created_at)
            self.lblTokenUpdated.text = "Updated: " + self.app.dateFormatter.string(from: token.updated_at)
            self.lblTokenType.text = "Type: " + token.instrument_type.rawValue
            self.lblTokenExpires.text = "Expires: " + self.app.dateFormatter.string(from: token.expires_at)
            self.lblTokenCurrency.text = "Currency: " + token.currency
        }
    }
    
    func displayError(error:Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "There was an error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
