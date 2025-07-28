//
//  LoginViewModel.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation
import SwiftUICleanArchitect


final class LoginViewModel: ViewModel, AuthenticationUseCase, @unchecked Sendable {
    let authenticationGateway: AuthenticationGatewayProtocol
    @Published var username: String = "admin"
    @Published var password: String = "123456"
    @Published var loginSuccess: Bool = false
    
    init(authenticationGateway:  AuthenticationGatewayProtocol) {
        self.authenticationGateway = authenticationGateway
    }
    
    func login() async {
        guard viewState == .loaded else { return }
        startLoading()
        do {
            try await login(username: username, password: password)
            Task { @MainActor in
                loginSuccess = true
            }
            endLoading()
        } catch {
            handleError(error)
        }
    }
}
