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
    @Environment(\.scenePhase) private var scenePhase
    var isFirstLaunch = true
    @StateObject var landingPageVM = LandingPageViewModel(storageProvider: StorageProvider())
    var body: some Scene {
        
        WindowGroup {
            if isFirstLaunch {
                FirstProjectView(vm: landingPageVM, storageProvider: landingPageVM.repository.storageProvider)
                    .environment(\.managedObjectContext, landingPageVM.repository.storageProvider.persistentContainer.viewContext)
                    
            } else {
                LandingPageView(vm: landingPageVM, _storageProvider: landingPageVM.repository.storageProvider)
                    .environment(\.managedObjectContext, landingPageVM.repository.storageProvider.persistentContainer.viewContext)
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                landingPageVM.repository.storageProvider.saveContext()
            @unknown default:
                print("unknown scene")
            }
        }
    }
}
