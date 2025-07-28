//
//  SplashView.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            LottieView(animation: .named("splash_animation"))
                .playing(loopMode: .loop)
                .frame(maxWidth: .infinity)
                .offset(y: -60)
            Text(viewModel.displayedText)
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold))
                .offset(y: 80)
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.startTypewriterAnimation()
            }
        }
        .onChange(of: viewModel.navigateToMain) { newValue in
            navigationManager.changeRootView(.main)
        }
        .onChange(of: viewModel.navigateToLogin) { newValue in
            navigationManager.changeRootView(.login)
        }
    }
}

#Preview {
    SplashView()
}
