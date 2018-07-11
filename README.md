# ios-sdk
Finix SDK for tokenizing cards on iOS 

1. import the Finix SDK the swift package manager
2. import the library into the file
```swift
import FinixSDK
```
3. The Finix SDK provides a FinixTokenizer class, a tokenize method on that class and a Token struct that will include the token in the 'id' property and the fingerprint in the 'fingerprint' property
```swift
let finixTokenizer = FinixTokenizer(host: "api-staging.finix.io", applicationId: "AP2kL9QSWYJGpuAtYYnK5cZY")
finixTokenizer.tokenize(expDate: txtExpiration.text!, cardNumber: txtNumber.text!) { (response, error) in
        guard let token = token else {
            print(error.localizedDescription)
            return
        } 
        print(token.id)
        print(token.fingerprint)
}
```
