//
//  ErrorView.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI
import SwiftUICleanArchitect

struct ErrorView: View {
    @EnvironmentObject var viewStateManager: ViewStateManager
    @Binding var error: IDError?

    var body: some View {
        Rectangle()
            .fill(.clear)
            .ignoresSafeArea()
            .alert(error: $error) {
                viewStateManager.isLoading = false
                viewStateManager.error = nil
            }
    }
}
