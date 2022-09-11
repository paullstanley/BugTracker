//
//  LandingPageView.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject var vm = LandingPageViewModel()
    
    var body: some View {
        TabView {
            NavigationSplitView {
                List(MenuItems.tempSidebar, selection: $vm.selectedMenu) { item in
                    HStack {
                        Label(item.name, systemImage: item.image)
                            .fixedSize()
                    }
                    .tag(item)
                }
            } detail: {
                if vm.selectedMenu?.name == "Create Ticket" {
                    CreateProjectView()
                    
                } else if vm.selectedMenu?.name == "Projects" {
                    ProjectsLandingPageView()
                }
                else if vm.selectedMenu?.name == "Home" ||
                            vm.selectedMenu?.name == "" ||
                            vm.selectedMenu?.name == nil
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
            ProjectsLandingPageView()
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


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}


