//
//  MenuItems.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI
import Domain

struct MenuItems {
    static let landingPageSideBar: [MenuItem] = [
        MenuItem(name: "Home", image: "house"),
        MenuItem(name: "Create Ticket", image: "doc.fill.badge.plus"),
        MenuItem(name: "Projects", image: "plus"),
        MenuItem(name: "My View", image: "person.fill"),
        MenuItem(name: "Tickets", image: "tray.fill"),
        MenuItem(name: "Changelog", image: "calendar")
    ]
    
    static let LandingPageTab: [MenuItem] = [
        MenuItem(name: "Home", image:  "house"),
        MenuItem(name: "Feed", image: "chart.xyaxis.line"),
        MenuItem(name: "Projects", image: "scale.3d")
    ]
    
    static let tempSidebar: [MenuItem] = [
        MenuItem(name: "Home", image: "house"),
        //MenuItem(name: "Create Ticket", image: "doc.fill.badge.plus"),
        MenuItem(name: "Projects", image: "plus")
    ]
    static let dashboardItems: [DashboardButtons] = [DashboardButtons(symbol: "doc.fill.badge.plus", label: "New Project ", color: Color.accentColor.gradient), DashboardButtons(symbol: "doc", label: "Open Project", color: Color.yellow.gradient), DashboardButtons(symbol: "chart.xyaxis.line", label: "     Feed      ", color: Color.teal.gradient), DashboardButtons(symbol: "scale.3d", label: "Project List", color: Color.mint.gradient), DashboardButtons(symbol: "house", label: "     Home      ", color: Color.brown.gradient),]
    
}
