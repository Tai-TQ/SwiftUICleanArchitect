//
//  NavigationManager.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation

@MainActor
final class NavigationManager: ObservableObject {
    enum RootViewType {
        case splash
        case login
        case main
    }

    enum ToastViewType {
        case none
        case S200_0301
        case S500_0201
        case S500_0202
        case S500_0203
        case S500_0204
        case S500_0301
        case S500_0303
        case S500_0304
        case S500_0305
        case S100_0402
        case DeleteReminderSuccess
        case CreateReminderSuccess
        case ReminderStatusON
        case ReminderStatusOFF
        case CopingActionAddFavorite
        case CopingActionUnFavorite
    }

    @Published private(set) var rootView = RootViewType.splash
    @Published private(set) var path: [Route] = []

    @Published var navigateToHomeOverlayView = false
    @Published var navigateToTab: Tab = .home
    @Published var showToastView: ToastViewType = .none

    func getCurrentRoute() -> Route {
        path.last ?? .none
    }

    func pushView(_ route: Route, forcePush: Bool = false) {
        if forcePush {
            path.append(route)
        } else {
            if path.isEmpty || path.last != route {
                path.append(route)
            }
        }
    }

    func popView() {
        if path.isNotEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        if path.isNotEmpty {
            path.removeAll()
        }
    }

    func popToView(_ route: Route) {
        if let index = path.firstIndex(of: route) {
            popTo(index: index)
        }
    }

    func popToBeforeView(_ route: Route) {
        if let index = path.firstIndex(of: route) {
            popTo(index: index - 1) // indexBeforeRoute = index - 1
        }
    }

    func containsRoute(_ route: Route) -> Bool {
        path.contains(route)
    }

    private func popTo(index: Int) {
        if path.count >= index + 1 {
            path.removeLast(path.count - (index + 1))
        }
    }

    // About Tab
    func openTab(_ tab: Tab) {
        popToRoot()
        navigateToTab = tab
    }

    func changeRootView(_ newRootView: RootViewType) {
        guard rootView != newRootView else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            rootView = newRootView
            popToRoot()
            if newRootView == .splash {
                navigateToTab = .home
            }
        }
    }
}

indirect enum Route: Hashable {
    case none
    case supportQA // Support QA to mock data
    case personalTest
    case S200_0301
    case S300_0101
    case S300_0105
    case S300_0106
    case S301_0101
}

