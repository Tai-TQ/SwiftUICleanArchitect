//
//  ContentView.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/25/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        switch navigationManager.rootView {
        case .splash:
            SplashView()
        case .login:
            LoginView()
        case .main:
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
