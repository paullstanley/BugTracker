//
//  IssueTrackingSystemApp.swift
//  Shared
//
//  Created by Paull Stanley on 9/6/22.
//

import SwiftUI

@main
struct IssueTrackingSystemApp: App {
    var isFirstLaunch = true

    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                FirstProjectView()
            } else {
                LandingPageView()
            }
            
        }
    }
}
