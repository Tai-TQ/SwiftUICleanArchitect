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
    
    @Published open var error: IDError? {
        didSet {
            if error != nil {
                viewState = .loaded
            }
        }
    }
    
    @Published open var viewState: ViewState = .loaded
    
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
        currentAPILoadingCount += 1
    }
    
    open func endLoading() {
        if currentAPILoadingCount == 0 {
            viewState = .loaded
        } else {
            currentAPILoadingCount -= 1
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
        currentAPIReloadingCount += 1
    }
    
    open func endReloading() {
        if currentAPIReloadingCount == 0 {
            viewState = .loaded
        } else {
            currentAPIReloadingCount -= 1
        }
    }
    
    // MARK: - HandleError
    open func handleError(_ error: Error) {
        if let err = error as? IDError {
            self.error = err
        } else {
            self.error = IDError(message: error.localizedDescription)
        }
    }
}
