//
//  VerticalScrollView.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 09/04/2024.
//

import SwiftUI

// Usage
// VStack {
//   // Your content
// }
// .verticalScrollIfNeed()

struct OverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow = false

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    GeometryReader { contentGeometry in
                        Color.clear.onAppear {
                            contentOverflow = contentGeometry.size.height > geometry.size.height
                        }
                    }
                )
                .wrappedInScrollView(when: contentOverflow)
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView {
                self
            }
        } else {
            self
        }
    }

    public func verticalScrollIfNeed() -> some View {
        modifier(OverflowContentViewModifier())
    }
}

