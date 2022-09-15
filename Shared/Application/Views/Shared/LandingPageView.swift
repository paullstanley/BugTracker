//
//  LandingPageView.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI
import StorageProvider

struct LandingPageView: View {
    let storageProvider: StorageProvider
    @ObservedObject var vm: LandingPageViewModel
    @State var someBool: Bool = false
    
    init(vm: LandingPageViewModel, _storageProvider: StorageProvider) {
        self.vm = LandingPageViewModel(storageProvider: _storageProvider)
        storageProvider = _storageProvider
    }
    
    var body: some View {
        TabView {
            NavigationSplitView {
                List(MenuItems.tempSidebar, selection: $vm.selectedMenu) { item in
                    DynamicStack {
                        Label(item.name, systemImage: item.image)
                            .fixedSize()
                    }
                    .tag(item)
                }
            } detail: {
                if vm.selectedMenu?.name == "Create Ticket" {
                    CreateProjectView(storageProvider: storageProvider)
                    
                } else if vm.selectedMenu?.name == "Projects" {
                    ProjectsLandingPageView(_storageProvider: storageProvider)
                }
                else if vm.selectedMenu?.name == "Home" ||
                            vm.selectedMenu?.name == "" ||
                            vm.selectedMenu?.name == nil
                {
                    WelcomePage(storageProvider: storageProvider)
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


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView(vm: LandingPageViewModel(storageProvider: StorageProvider()), _storageProvider: StorageProvider())
    }
}


