//
//  Binding+Extensions.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
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
