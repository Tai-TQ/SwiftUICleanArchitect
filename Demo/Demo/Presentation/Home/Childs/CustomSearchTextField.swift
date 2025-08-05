//
//  CustomSearchTextField.swift
//  Demo
//
//  Created by truong.quoc.tai on 8/5/25.
//

import SwiftUI

struct CustomSearchTextField: View {
    @Binding var text: String
    var placeholder: String = "Search..."
    var onCommit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.system(size: 16, weight: .medium))
            
            // Text Field
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())
                .onSubmit {
                    onCommit?()
                    isFocused = false
                }
            
            // Clear Button
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isFocused ? Color.accentColor : Color.clear, lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

// MARK: - Preview
struct CustomSearchTextField_Previews: PreviewProvider {
    @State static private var searchText = ""
    
    static var previews: some View {
        VStack(spacing: 20) {
            CustomSearchTextField(text: $searchText, placeholder: "Search countries...")
            
            CustomSearchTextField(
                text: $searchText,
                placeholder: "Custom placeholder...",
                onCommit: {
                    print("Search submitted: \(searchText)")
                }
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
