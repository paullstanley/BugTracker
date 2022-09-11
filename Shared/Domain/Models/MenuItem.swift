//
//  MenuItem.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import Foundation

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var subMenuItems: [MenuItem]?
}
