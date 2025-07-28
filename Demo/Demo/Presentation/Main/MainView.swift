//
//  MainView.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var navigationPath = NavigationPath()
    @State private var selectedTag = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        let selectable = Binding(
            get: { self.selectedTag },
            set: {
                navigationManager.navigateToTab = Tab($0)
            }
        )
        NavigationStack(path: $navigationPath) {
            TabView(selection: selectable) {
                HomeView()
                    .tag(Tab.home.tabValue)
                
                ProfileView()
                    .tag(Tab.profile.tabValue)
                    
            }
        }
        .overlay(alignment: .bottom, content: {
            VStack(spacing: 0) {
                CustomTabBar(currentTab: selectable)
            }
        })
        .onChange(of: navigationManager.path) { path in
            DispatchQueue.main.async {
                navigationPath = NavigationPath()
                if path.isNotEmpty {
                    path.forEach { route in
                        navigationPath.append(route)
                    }
                }
            }
        }
        .onChange(of: navigationManager.navigateToTab) { newValue in
            selectedTag = newValue.tabValue
        }
    }
}

#Preview {
    MainView()
}
