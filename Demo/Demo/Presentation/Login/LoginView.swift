//
//  LoginView.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel(authenticationGateway: AuthenticationGatewayMock())
    @EnvironmentObject var viewStateManager: ViewStateManager
    @EnvironmentObject var navigationManager: NavigationManager
    
    init() {
        print("LoginView init")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            
            Button("Login") {
                login()
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
        }
        .padding()
        .onChange(of: viewModel.error) { viewStateManager.error = $0 }
        .onChange(of: viewModel.viewState) { newValue in
            viewStateManager.isLoading = newValue == .loading
        }
        .onChange(of: viewModel.loginSuccess) { isSuccess in
            if isSuccess {
                navigationManager.changeRootView(.main)
            }
        }
    }
    
    private func login() {
        let vm = viewModel
        Task {
            await vm.login()
        }
    }
}

#Preview {
    LoginView()
}
