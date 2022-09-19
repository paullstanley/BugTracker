//
//  IssueTrackingSystemApp.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI
import Application
import CoreDataPlugin


@main
struct IssueTrackingSystemApp: App {
    let storageProvider = StorageProvider()
    @Environment(\.scenePhase) private var scenePhase
    var isFirstLaunch = false
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                FirstProjectView(vm: LandingPageViewModel(storageProvider: storageProvider), storageProvider: storageProvider)
            } else {
                LandingPageView(vm: LandingPageViewModel(storageProvider: storageProvider), _storageProvider: storageProvider)
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
                // landingPageVM.repository.storageProvider.saveContext()
            @unknown default:
                print("unknown scene")
            }
        }
    }
}

