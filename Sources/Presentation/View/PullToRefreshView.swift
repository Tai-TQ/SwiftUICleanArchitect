//
//  RefreshableScrollView.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 26/03/2024.
//

import SwiftUI

public struct RefreshableScrollView<Content:View>: View {
    private var viewState: ViewState = .loaded
    private var enableLoadMore: Bool = true
    private var refreshAction: () async -> Void
    private var loadMoreAction: () -> Void
    private var content: () -> Content
    private let threshold: CGFloat = 50.0
    
    init(viewState: ViewState,
         enableLoadMore: Bool,
         refreshAction: @escaping () async -> Void,
         loadMoreAction: @escaping () -> Void,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.enableLoadMore = enableLoadMore
        self.refreshAction = refreshAction
        self.loadMoreAction = loadMoreAction
        self.viewState = viewState
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    content()
                        .anchorPreference(key: OffsetBottomPreferenceKey.self, value: .bottom) {
                            geometry[$0].y
                        }
                    if viewState == .loadingMore {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .onPreferenceChange(OffsetBottomPreferenceKey.self) { offset in
                    if offset < geometry.size.height - threshold,
                        viewState == .loaded,
                        enableLoadMore  {
                        loadMoreAction()
                    }
                }
                .refreshable {
                    await Task {
                        await refreshAction()
                    }.value
                }
            }
        }
    }
}

fileprivate struct OffsetBottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

fileprivate struct OffsetTopPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
