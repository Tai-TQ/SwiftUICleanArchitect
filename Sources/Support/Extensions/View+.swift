//
//  File.swift
//  SwiftUICleanArchitect
//
//  Created by truong.quoc.tai on 8/5/25.
//

import SwiftUI

public extension View {
    public func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}
