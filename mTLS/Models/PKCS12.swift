//
//  PKCS12.swift
//  mTLS
//
//  Created by Ravi on 26/09/23.
//

import Foundation
import Security

struct PKCS12 {
    /// The extracted identity from the PKCS12 file.
    let identity: SecIdentity
    
    /// Initializes a PKCS12 instance using certificate data and a password.
    /// - Parameters:
    ///   - certificateData: The PKCS12 certificate data.
    ///   - password: The password to unlock the PKCS12 file.
    init(certificateData: Data, password: String) {
        // Import the certificate and key from PKCS12 format using the provided password
        var importedItems: CFArray?
        let options = [kSecImportExportPassphrase as String: password]
        let importStatus = SecPKCS12Import(certificateData as CFData, options as CFDictionary, &importedItems)
        
        // Check if the import was successful
        guard importStatus == errSecSuccess else {
            fatalError("Failed to import P12 file. Error code: \(importStatus)")
        }
        
        // Extract the identity from the imported items
        guard let itemsArray = importedItems as? [[String: AnyObject]],
              let firstItem = itemsArray.first,
              let identity = firstItem[kSecImportItemIdentity as String] as! SecIdentity?
        else {
            fatalError("Failed to extract identity from the P12 file")
        }
        
        // Assign the extracted identity to the struct property
        self.identity = identity
    }
    
    /// Initializes a PKCS12 instance using a P12 file with a given filename and password.
    /// - Parameters:
    ///   - fileName: The name of the P12 file (without extension)
    ///   - password: The password to unlock the P12 file.
    init(fileName: String, password: String) {
        // Load the P12 file from the app's bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "p12") else {
            fatalError("Failed to load client P12 file.")
        }
        do {
            let certificateData = try Data(contentsOf: url)
            self.init(certificateData: certificateData, password: password)
        } catch  {
            fatalError("Failed to read P12 file: \(error)")
        }
    }
}
