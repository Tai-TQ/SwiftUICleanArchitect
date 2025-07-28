//
//  AppSettings.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation
import SwiftUICleanArchitect

final class AppSettings {
    nonisolated(unsafe) static let shared = AppSettings()
    
    private init() {}
    
    @Storage(key: "loginSuccessful", defaultValue: false)
    var loginSuccessful: Bool
    
}
