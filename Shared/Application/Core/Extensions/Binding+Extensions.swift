//
//  Binding+Extensions.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI

extension Binding {
    func withDefault<Default>(_ defaultValue: Default) -> Binding<Default> where Value == Default? {
        .init(
            get: {
                wrappedValue ?? defaultValue
            },
            set: { newValue in
                wrappedValue = newValue
            }
        )
    }
}
