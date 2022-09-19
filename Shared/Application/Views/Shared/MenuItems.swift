//
//  MenuItems.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import Foundation
import Domain

struct MenuItems {
    static let landingPageSideBar = [
        MenuItem(name: "Home", image: "house"),
        MenuItem(name: "Create Ticket", image: "doc.fill.badge.plus"),
        MenuItem(name: "Projects", image: "plus"),
        MenuItem(name: "My View", image: "person.fill"),
        MenuItem(name: "Tickets", image: "tray.fill"),
        MenuItem(name: "Changelog", image: "calendar")
    ]
    
    static let LandingPageTab = [
        MenuItem(name: "Home", image:  "house"),
        MenuItem(name: "Feed", image: "chart.xyaxis.line"),
        MenuItem(name: "Projects", image: "scale.3d")
    ]
    
    static let tempSidebar = [
        MenuItem(name: "Home", image: "house"),
        MenuItem(name: "Create Ticket", image: "doc.fill.badge.plus"),
        MenuItem(name: "Projects", image: "plus")
    ]
}
