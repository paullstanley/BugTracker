//
//  LandingPageView.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI
import CoreDataPlugin

public struct LandingPageView: View {
    let storageProvider: StorageProvider
    @ObservedObject var landingPageVM: LandingPageViewModel
    
    public init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        self.landingPageVM = LandingPageViewModel(storageProvider: self.storageProvider)
    }
    
    public var body: some View {
        TabView {
                NavigationSplitView {
                    List(MenuItems.tempSidebar, selection: $landingPageVM.selectedMenu) { item in
                            Label(item.name, systemImage: item.image)
                                .fixedSize()
                                .tag(item)
                    }
                } detail: {
                    if landingPageVM.selectedMenu?.name == "Create Ticket" {
                        //AddProjectView()
                        
                    } else if landingPageVM.selectedMenu?.name == "Projects" {
                        ProjectsLandingPageView(storageProvider: storageProvider)
                    }
                    else if landingPageVM.selectedMenu?.name == "Home" ||
                                landingPageVM.selectedMenu?.name == "" ||
                                landingPageVM.selectedMenu?.name == nil
                    {
                        WelcomePage()
                    }
                }
            .tabItem {
                Label("Home", systemImage: "house")
                    .fixedSize()
            }
            Text("Feed")
                .tabItem{
                    Label("Feed", systemImage: "chart.xyaxis.line")
                        .fixedSize()
                }
                .tabItem {
                    Label("Projects", systemImage: "scale.3d")
                        .fixedSize()
                }
        }
        .padding()
        .scaleEffect()
        .navigationTitle("")
        .toolbar {
            HeaderToolbar()
        }
    }
}
