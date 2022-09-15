//
//  IssueTrackingSystemApp.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI
import StorageProvider

@main
struct IssueTrackingSystemApp: App {
    let storage = StorageProvider()
    var isFirstLaunch = true

    var body: some Scene {
        let landingPageVM = LandingPageViewModel(_storageProvider: storage)
        WindowGroup {
            if isFirstLaunch {
                FirstProjectView(vm: landingPageVM, _storageProvider: storage)
                    .environment(\.managedObjectContext, storage.persistentContainer.viewContext)
                    
            } else {
                LandingPageView(vm: landingPageVM, _storageProvider: storage)
                    .environment(\.managedObjectContext, storage.persistentContainer.viewContext)
            }
            
        }
    }
}
