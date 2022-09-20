//
//  iOSMainView.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

public struct iOSMainView: View {
    @State var selectedMenu: MenuItem?
    let storageProvider: StorageProvider
    
    public init() {
        self.storageProvider = StorageProvider()
    }
    
    public var body: some View {
        NavigationSplitView {
            List(MenuItems.tempSidebar, selection: $selectedMenu) { item in
                Label(item.name, systemImage: item.image)
                    .tag(item)
            }
        } detail: {
            if selectedMenu?.name == "Projects" {
                ProjectsLandingPageView(storageProvider: storageProvider)
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
