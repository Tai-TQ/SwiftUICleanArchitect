//
//  RefreshableListView.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 28/06/24.
//

import SwiftUI

public struct RefreshableListView<Content: View>: View {
    private var viewState: ViewState
    private var refreshAction: () async -> Void
    private var content: () -> Content

    public init(viewState: ViewState,
                refreshAction: @escaping () async -> Void,
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.refreshAction = refreshAction
        self.viewState = viewState
    }

    public var body: some View {
        List {
            VStack(spacing: 0) {
                content()
                if viewState == .loadingMore {
                    ProgressView()
                        .tint(.black)
                        .progressViewStyle(.circular)
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .listStyle(PlainListStyle())
        .refreshable {
            await Task {
                await refreshAction()
            }.value
        }
    }
}
