//
//  URLSessionMTLS.swift
//  mTLS
//
//  Created by Ravi on 28/09/23.
//

import Foundation

/// Extension for URLSession to support manual TLS configuration.
class URLSessionMTLS {
    /// Private static variable to store the manually configured TLS session.
    static private var _session: URLSession? = nil
    
    /// Private static variable to store the delegate for the manually configured TLS session.
    static private var delegate: URLSessionMTLSDelegate?
    
    /// Accessor for the manually configured TLS session.
    /// Throws a fatalError if accessed before configuration. Call configureMTLSSession before using manualTSLSession.
    static var shared: URLSession {
        guard let session = _session else {
            fatalError("manualTSLSession accessed before configuration. Call configureMTLSSession before using manualTSLSession.")
        }
        return session
    }
    
    /// Configures a TLS session with a given certificate file and password.
    ///
    /// - Parameters:
    ///   - certificateFileName: The name of the certificate file.
    ///   - password: The password for accessing the certificate.
    static func configure(certificateFileName: String, password: String) {
        let identity = PKCS12(fileName: certificateFileName, password: password).identity
        delegate = URLSessionMTLSDelegate(secIdentity: identity)
        _session = URLSession(configuration: .default, delegate: delegate, delegateQueue: .none)
    }
}
