//
//  AppDelegate.swift
//  mTLS
//
//  Created by Ravi on 26/09/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Configure url sesssion to handle manual TLS authentication
        // TODO: Add .p12 certificate file inside project
        // TODO: Provide the actual certificate file name and password below, then comment this line.
        #error("Please provide certificate file name and password before running.")
        URLSessionMTLS.configure(certificateFileName: "certificate_file_name_p12", password: "password_phrase")
        return true
    }
}
