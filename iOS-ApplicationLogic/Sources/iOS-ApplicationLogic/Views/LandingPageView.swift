//
//  iOSMainView.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

public struct LandingPageView: View {
    @StateObject private var landingPageVM =  LandingPageViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    @State private var selectedMenu: MenuItem?
    
    public init() { }
    
    public var body: some View {
        DynamicStack {
            NavigationSplitView {
                List(MenuItems.tempSidebar, selection: $selectedMenu) { item in
                    Label(item.name, systemImage: item.image)
                        .tag(item)
                }
            } detail: {
                if selectedMenu?.name == "Projects" {
                    ProjectListView()
                } else if selectedMenu?.name == "Create Ticket" {
                    AddProjectView()
                }
                else if selectedMenu?.name == "Home" ||
                            selectedMenu?.name == "" ||
                            selectedMenu?.name == nil
                {
                    WelcomePage()
                }
            }
        }

        
    }
}
