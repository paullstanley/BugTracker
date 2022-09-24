//
//  LandingPageView.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI
import UseCases
import CoreDataPlugin

public struct LandingPageView: View {
    @StateObject var landingPageVM = LandingPageViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
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
                       // AddProjectView(projects: $landingPageVM.projects)
                        
                    } else if landingPageVM.selectedMenu?.name == "Projects" {
                        ProjectsLandingPageView()
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
