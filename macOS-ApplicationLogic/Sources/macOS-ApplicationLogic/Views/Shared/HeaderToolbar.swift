//
//  HeaderToolbar.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI

struct HeaderToolbar: ToolbarContent {
    @State var accountInfoIsShowing: Bool = false
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Button {
                withAnimation {
                    accountInfoIsShowing.toggle()
                }
            } label: {
                VStack {
                    Image(systemName: "person.circle")
                        .imageScale(Image.Scale.large)
                        .foregroundColor(.accentColor)
                    Text("Account")
                        .font(.callout)
                }
                .bold()
                .popover(isPresented: $accountInfoIsShowing, content: {
                    ProfileSettingsView()
                })
            }
            .buttonStyle(.plain)
            .fixedSize()
            .padding()
            
        }
    }
}
