//
//  SplashViewModel.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import SwiftUI
import SwiftUICleanArchitect

final class SplashViewModel: ViewModel {
    @Published var navigateToMain: Bool = false
    @Published var navigateToLogin: Bool = false
    
    deinit {
        print("SplashViewModel deinitialized")
    }
    
    @MainActor
    func checkAuthentication() async {
        try? await Task.sleep(for: .seconds(1.5))
        if AuthManager.shared.isAuthenticated {
            navigateToMain = true
        } else {
            navigateToLogin = true
        }
    }
}
