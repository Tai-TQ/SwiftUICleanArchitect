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
    @Published var displayedText = ""
    private var fullText = "Globe Wise"
    
    deinit {
        print("SplashViewModel deinitialized")
    }
    
    @MainActor
    func startTypewriterAnimation() async {
        displayedText = ""
        
        while !fullText.isEmpty {
            try? await Task.sleep(for: .milliseconds(200))
            displayedText += String(fullText.removeFirst())
        }
        
        try? await Task.sleep(for: .milliseconds(300))
        if AuthManager.shared.isAuthenticated {
            navigateToMain = true
        } else {
            navigateToLogin = true
        }
    }
    
}
