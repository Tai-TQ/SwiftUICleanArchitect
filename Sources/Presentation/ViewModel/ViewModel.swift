//
//  ViewModel.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 26/03/2024.
//

import Combine
import SwiftUI

public enum ViewState {
    case loaded, loading, loadingMore, reloading
}

open class ViewModel: ObservableObject {
    
    public init() {}
    
    @Published open private (set) var error: IDError? {
        didSet {
            if error != nil {
                viewState = .loaded
            }
        }
    }
    
    @Published open private (set) var viewState: ViewState = .loaded
    
    // MARK: - Loading
    private var currentAPILoadingCount = 0 {
        didSet {
            if currentAPILoadingCount > 0 {
                viewState = .loading
            } else {
                viewState = .loaded
            }
        }
    }
    
    open func startLoading() {
        Task { @MainActor in
            currentAPILoadingCount += 1
        }
    }
    
    open func endLoading() {
        Task { @MainActor in
            if currentAPILoadingCount == 0 {
                viewState = .loaded
            } else {
                currentAPILoadingCount -= 1
            }
        }
    }
    
    // MARK: - Reloading
    private var currentAPIReloadingCount = 0 {
        didSet {
            if currentAPIReloadingCount > 0 {
                viewState = .reloading
            } else {
                viewState = .loaded
            }
        }
    }
    
    open func startReloading() {
        Task { @MainActor in
            currentAPIReloadingCount += 1
        }
    }
    
    open func endReloading() {
        Task { @MainActor in
            if currentAPIReloadingCount == 0 {
                viewState = .loaded
            } else {
                currentAPIReloadingCount -= 1
            }
        }
    }
    
    // MARK: - HandleError
    open func handleError(_ error: Error) {
        Task { @MainActor in
            currentAPILoadingCount = 0
            currentAPIReloadingCount = 0
            if let err = error as? IDError {
                self.error = err
            } else if let error = error as? APIErrorBase {
                self.error = IDError(message: error.errorDescription)
            } else {
                self.error = IDError(message: error.localizedDescription)
            }
        }
    }
}
