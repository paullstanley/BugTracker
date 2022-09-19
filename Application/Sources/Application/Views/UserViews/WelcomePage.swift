//  WelcomePage.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.

import SwiftUI

struct WelcomePage: View {
    var body: some View {
#if os(iOS)
        iOSWelcomePageVIew()
#else
        VStack {
            Text(String(describing: Date().formatted()))
                .fontWeight(.ultraLight)
            Text("Welcome")
                .font(.title)
                .fontWeight(.heavy)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
                ForEach(0..<MenuItems.dashboardItems.count, id: \.self) { i in
                    NavigationLink(destination: //CreateProjectView(storageProvider: storageProvider)
                                   Text("hello"), label: {
                        VStack {
                            Image(systemName: MenuItems.dashboardItems[i].symbol)
                                .resizable()
                            
                            Text(MenuItems.dashboardItems[i].label)
                                .fixedSize()
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(MenuItems.dashboardItems[i].color)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                    })
                    .buttonStyle(.plain)
                    .padding()
                }.aspectRatio(3.5/4, contentMode: .fit )
            }
            .padding(.horizontal)
        }
        .scaleEffect()
#endif
    }
}
