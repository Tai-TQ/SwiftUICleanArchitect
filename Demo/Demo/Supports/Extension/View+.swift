//
//  View+.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI
import SwiftUICleanArchitect

extension View {
    func alert(error: Binding<IDError?>, dismissAction: (() -> Void)? = nil) -> some View {
        alert(item: error) { err in
            Alert(
                title: Text("Error"),
                message: Text(err.localizedDescription),
                dismissButton: .default(
                    Text("OK"),
                    action: {
                        dismissAction?()
                    }
                )
            )
        }
    }
}
