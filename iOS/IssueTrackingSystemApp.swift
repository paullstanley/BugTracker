//
//  IssueTrackingSystemApp.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/20/22.
//



import SwiftUI
import Application

@main
struct IssueTrackingSystemApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            iOSLandingPageView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            @unknown default:
                print("unknown scene")
            }
        }
    }
}

