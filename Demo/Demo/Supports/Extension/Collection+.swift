//
//  Collection+.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
