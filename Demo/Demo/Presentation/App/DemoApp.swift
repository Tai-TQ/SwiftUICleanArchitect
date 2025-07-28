//
//  DemoApp.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/25/25.
//

import SwiftUI
import SwiftUICleanArchitect

@main
struct DemoApp: App {
    @StateObject var navigationManager = NavigationManager()
    @StateObject var viewStateManager = ViewStateManager()
    @StateObject var viewModel = DemoAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if viewStateManager.isLoading, viewStateManager.error == nil {
                    LoadingView()
                }
                if viewStateManager.error != nil {
                    ErrorView(error: $viewStateManager.error)
                }
                
            }
            .environmentObject(navigationManager)
            .environmentObject(viewStateManager)
        }
    }
}
