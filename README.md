
# ios-sdk

1. import the Finix SDK with carthage by adding `github "finix-payments/ios-sdk" ~> 1.0` to cartfile
2. import the library into the file
```swift
import FinixSDK
```
3. The Finix sdk provides a FinixTokenizer class, a tokenize method on that class and a Token struct that will include the token in the 'id' property and the fingerprint in the 'fingerprint' property
```swift
let finixTokenizer = FinixTokenizer(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
finixTokenizer.tokenize(expDate: txtExpiration.text!, cardNumber: txtNumber.text!) { (token, error) in
        guard let token = token else {
            print(error!.localizedDescription)
            return
        } 
        print(token.id)
        print(token.fingerprint)
}
```
