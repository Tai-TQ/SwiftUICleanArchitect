//
//  LoadingView.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI
import SwiftUICleanArchitect

@MainActor
class ViewStateManager: ObservableObject {
    @Published var isLoading = false
    @Published var error: IDError?
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .tint(.white)
                    .controlSize(.large)
            }
        }
    }
}

#Preview {
    LoadingView()
}
