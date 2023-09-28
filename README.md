# Mutual TLS Authentication(mTLS) - Swift

This demo demonstrates how to implement mutual TLS authentication (mTLS) in Swift. mTLS is a security mechanism that allows both the client and server to authenticate each other using their own digital certificates. This is in contrast to traditional TLS, where only the server authenticates itself to the client.

**Instructions**

1. Create a PKCS12 file containing your client certificate and key.
2. Add the PKCS12 file to your project.
3. Update the `certificateFileName` and `password` variables in the `AppDelegate` class to match your PKCS12 file.
4. Run the app.

**Example Usage**

To perform a request using the manually configured TLS session, simply use the `URLSessionMTLS.shared` object:

```swift
let session = URLSessionMTLS.shared

// Create a request to the server
let request = URLRequest(url: URL(string: "https://example.com/api")!)

// Send the request
session.dataTask(with: request) { data, response, error in
  // Handle the response
}.resume()
```

**Note:** You must add a `.p12` certificate file to your project and update the `certificateFileName` and `password` variables in the `AppDelegate` class before running the app.

**References**

* Mutual TLS authentication: [Mutual_TLS_authentication](https://medium.com/@adi_bhat/mtls-implementation-on-ios-through-cloudflare-ef1ef2b36b33)

**License**

This demo is licensed under the MIT License.
