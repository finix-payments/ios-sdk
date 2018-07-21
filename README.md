
# ios-sdk

1. import the Payments SDK with with cocoapods by adding `pod 'PaymentsSDK', '~> 1.0.0'` to the Podfile
2. import the library into the file
```swift
import PaymentsSDK
```
3. The Payments sdk provides a Tokenizer class, a createToken method on that class and a Token struct that will include the token in the 'id' property and the fingerprint in the 'fingerprint' property
```swift 
// paymentType parameter can be added with the public enum PaymentType from the library
let tokenizer = Tokenizer(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
tokenizer.createToken(cardNumber: txtNumber.text!, paymentType: PaymentType.PAYMENT_CARD, expMonth: 12, expYear: 2021) { (token, error) in
        guard let token = token else {
            print(error!.localizedDescription)
            return
        }
        print(token.id)
        print(token.fingerprint)
}
```
