//
//  ViewController.swift
//  ios-example-sdk-ui
//
//  Created by Matt Sommer on 4/3/18.
//  Copyright © 2018 Finix Payments, Inc. All rights reserved.
//

import UIKit
import sdk

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
    
    let api = PaymentsSDK(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
    
    let app : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let expirationPredicate = NSPredicate(format:"SELF MATCHES %@", "^[0-9]{2}\\/[0-9]{4}")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitBtn(_ sender: Any) {
        do {
            //Call the SDK to tokenize a payment instrument
            api.tokenize(instrument: try buildInstrumentFromForm()) { (token, error) in
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
    
    //Extract form fields and build a payment instrument
    func buildInstrumentFromForm() throws -> Instrument {
        guard
            let expirationStr = txtExpiration.text, //Extract the expiration string from the text box
            expirationPredicate.evaluate(with: expirationStr), //Validate the expiration string has valid form
            let expirationMonth = Int(String((expirationStr.prefix(2)))), //Extract the month from the string
            let expirationYear = Int(String((expirationStr.suffix(4)))) //Extract the year from the string
        else {
            throw UIError.invalidExpiration
        }
        guard let number = txtNumber.text else {
            throw UIError.invalidCardNumber
        }
        return Instrument(type: PaymentType.PAYMENT_CARD, number: number, expiration_month: expirationMonth, expiration_year: expirationYear)
    }
    
    //Set the view in the app
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
    
    //Display an error message
    func displayError(error:Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "There was an error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
