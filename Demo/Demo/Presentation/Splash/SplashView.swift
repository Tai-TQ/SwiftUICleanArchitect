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
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            LottieView(animation: .named("splash_animation"))
                .playing(loopMode: .loop)
                .frame(maxWidth: .infinity)
                .offset(y: -60)
            Text("Globe Wise")
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold))
                .offset(y: 80)
                .opacity(opacity)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                opacity = 1.0
            }
            Task {
                await viewModel.checkAuthentication()
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
