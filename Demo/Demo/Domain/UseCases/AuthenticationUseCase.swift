//
//  AuthenticationUseCase.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation

protocol AuthenticationUseCase {
    var authenticationGateway: AuthenticationGatewayProtocol { get }
}

extension AuthenticationUseCase {
    func login(username: String, password: String) async throws {
        try await authenticationGateway.login(username: username, password: password)
    }
}
