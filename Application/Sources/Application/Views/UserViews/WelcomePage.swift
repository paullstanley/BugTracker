//  WelcomePage.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.

import SwiftUI
import Domain

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
                    NavigationLink {
                            if(MenuItems.dashboardItems[i].label == "New Project ") {
                                Text("New Project")
                            } else if(MenuItems.dashboardItems[i].label == "Open Project") {
                                Text("Open Project")
                            } else if(MenuItems.dashboardItems[i].label == "     Feed      ") {
                                Text("Feed")
                            } else if(MenuItems.dashboardItems[i].label == "     Home      ") {
                                Text("Home")
                            } else if(MenuItems.dashboardItems[i].label == "Project List") {
                                Text("Project List")
                            }
                    }
                label: {
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
                    }
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
