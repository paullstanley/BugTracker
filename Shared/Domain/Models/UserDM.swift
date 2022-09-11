//
//  UserDM.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

struct UserDM {
    var id: String = ""
    var password: String?
    var username: String?
    var projects: [ProjectDM]?
}

extension UserDM {
    func toManagedModel(in context: NSManagedObjectContext)-> UserMO {
        let user = UserMO.init(context: context)
        user.password = password
        user.username = username ?? ""
        user.projects = []
        
        return user
    }
}

extension UserDM: Identifiable { }

extension UserDM: Codable { }
