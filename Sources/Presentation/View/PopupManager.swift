//
//  PopupManager.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 23/04/2024.
//

import SwiftUI

open class PopupManager: ObservableObject {
    @Published open var isShowingPopup = false
    @Published open var popupContent: AnyView = .init(EmptyView())

    open func showPopup<Content: View>(_ view: Content) {
        if isShowingPopup { return }
        popupContent = AnyView(view)
        withAnimation(.easeIn(duration: 0.3)) {
            isShowingPopup = true
        }
    }

    open func hidePopup() {
        withAnimation(.easeOut(duration: 0.2)) {
            isShowingPopup = false
        }
    }
}

