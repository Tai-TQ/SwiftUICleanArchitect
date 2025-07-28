//
//  AuthManager.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation

final class AuthManager: @unchecked Sendable {
    static let shared = AuthManager()
    
    private init() {}
    
    var isAuthenticated: Bool {
        AppSettings.shared.loginSuccessful
    }
    
}

