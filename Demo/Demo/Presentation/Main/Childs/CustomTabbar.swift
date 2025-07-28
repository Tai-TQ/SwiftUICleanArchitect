//
//  CustomTabbar.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI

enum Tab: Equatable {
    case home
    case profile
    
    var tabValue: Int {
        switch self {
        case .home:
            return 0
        case .profile:
            return 1
        }
    }

    init(_ value: Int) {
        if value == 0 {
            self = .home
        } else {
            self = .profile
        }
    }
}


struct CustomTabBar: View {
    @Binding var currentTab: Int

    init(currentTab: Binding<Int>) {
        _currentTab = currentTab
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                TabButton(image: Image(systemName: "house.circle"),
                          title: "Home",
                          tabIndex: Tab.home.tabValue,
                          currentTab: $currentTab)
                    .frame(maxWidth: .infinity)

                TabButton(image: Image(systemName: "person.crop.circle"),
                          title: "Profile",
                          tabIndex: Tab.profile.tabValue,
                          currentTab: $currentTab)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 60)
            .background(
                Color.tabbarBackground
                    .ignoresSafeArea(.all)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: -2)
            )
        }
    }
}

extension CustomTabBar {
//    private var buttonCenter: some View {
//        Button {
//            action()
//        } label: {
//            Image(asset: Asset.iconPlus)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 40, height: 40)
//                .foregroundStyle(Color.white)
//        }
//        .size(Constant.SIZE_FLOAT_BUTTON)
//        .background(Color.semanticSurfaceBlandSecondary)
//        .clipShape(Circle())
//        .shadow(color: Color.floatButtonShadow.opacity(0.4), radius: 10, x: 0, y: 0)
//        .overlay(
//            Circle()
//                .inset(by: 1.5)
//                .stroke(Color.semanticBorderOnbrand, lineWidth: 3)
//        )
//    }
}

struct TabButton: View {
    var image: Image
    var title: String
    var tabIndex: Int
    @Binding var currentTab: Int

    var body: some View {
        Button(action: {
            currentTab = tabIndex
        }, label: {
            VStack(spacing: 0) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(colorImage())
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(colorTitle())
            }
            .frame(maxWidth: .infinity)
        })
    }
}

// MARK: Extension TabButton

extension TabButton {
    private func colorImage() -> Color {
        currentTab == tabIndex ?
            Color.primaryColor :
        Color.primary.opacity(0.5)
    }

    private func colorTitle() -> Color {
        currentTab == tabIndex ?
            Color.primaryColor :
            Color.primaryColor.opacity(0.5)
    }
}
