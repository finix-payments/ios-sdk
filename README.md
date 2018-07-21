
# ios-sdk

1. import the Payments SDK with with cocoapods by adding `github "finix-payments/ios-sdk" ~> 1.2` to cartfile
2. import the library into the file
```swift
import PaymentsSDK
```
3. The Finix sdk provides a FinixTokenizer class, a tokenize method on that class and a Token struct that will include the token in the 'id' property and the fingerprint in the 'fingerprint' property
```swift 
// paymentType parameter can be added with the public enum PaymentType from the library
let tokenizer = Tokenizer(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
finixTokenizer.createToken(cardNumber: txtNumber.text!, paymentType: PaymentType.PAYMENT_CARD, expMonth: 12, expYear: 2021) { (token, error) in
        guard let token = token else {
            print(error!.localizedDescription)
            return
        }
        print(token.id)
        print(token.fingerprint)
}
```
