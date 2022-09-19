//
//  DynamicStack.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/15/22.


import SwiftUI
import Domain

struct DynamicStack<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @ViewBuilder var content: ()-> Content

    var body: some View {
        currentLayout(content)
            .animation(.default, value: sizeClass)
    }
}

private extension DynamicStack {
    var currentLayout: AnyLayout {
        switch sizeClass {
        case .regular, .none:
            return horizontalLayout
        case .compact:
            return verticalLayout
//        case .some(_):
//            return verticalLayout
        }
    }

    var horizontalLayout: AnyLayout {
        AnyLayout(HStackLayout(
            alignment: verticalAlignment,
            spacing: spacing
        ))
    }

    var verticalLayout: AnyLayout {
        AnyLayout(VStackLayout(
            alignment: horizontalAlignment,
            spacing: spacing
        ))
    }
}
