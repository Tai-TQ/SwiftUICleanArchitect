//
//  AuthenticationGateway.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation
import SwiftUICleanArchitect

protocol AuthenticationGatewayProtocol {
    func login(username: String, password: String) async throws
}

struct AuthenticationGateway: AuthenticationGatewayProtocol {
    func login(username: String, password: String) async throws {
        // handle the login logic here
    }
}

struct AuthenticationGatewayMock: AuthenticationGatewayProtocol {
    func login(username: String, password: String) async throws {
        try await Task.sleep(for: .seconds(1))
        if username.lowercased() != "admin" || password.lowercased() != "123456" {
            throw IDError(message: "Invalid username or password")
        }
        AppSettings.shared.loginSuccessful = true
        debugPrint("Login successful for user: \(username)")
    }
}
