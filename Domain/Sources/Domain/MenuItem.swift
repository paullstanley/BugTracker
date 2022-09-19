//
//  MenuItem.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import Foundation

public struct MenuItem: Identifiable, Hashable {
    public init(name: String, image: String, subMenuItems: [MenuItem]? = nil) {
        self.id =  UUID()
        self.name = name
        self.image = image
        self.subMenuItems = subMenuItems
    }
    
    public var id = UUID()
    public var name: String
    public var image: String
    public var subMenuItems: [MenuItem]?
}
