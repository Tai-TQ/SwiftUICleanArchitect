//
//  IDError.swift
//  SwiftUICleanArchitect
//
//  Created by Truong Quoc Tai on 26/03/2024.
//

import Foundation

open class IDError: LocalizedError, Identifiable, Equatable {
    public let id = UUID().uuidString
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        message
    }
    
    public static func == (lhs: IDError, rhs: IDError) -> Bool {
        lhs.id == rhs.id
    }
}
