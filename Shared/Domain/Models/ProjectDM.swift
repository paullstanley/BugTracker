//
//  ProjectDM.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

struct ProjectDM {
    var id: String = ""
    var name: String
    var creationDate: String = String(describing: Date())
    var info: String?
    var stage: String?
    var deadline: String?
    var issues: [IssueDM]?
    var team: [UserDM]?
}

extension ProjectDM {
    var issueCount: String {
        String(describing: issues?.count ?? 0)
    }
}

extension ProjectDM {
    func toManagedModel(in context: NSManagedObjectContext)-> ProjectMO {
        let dateFormatter = DateFormatter()
        let project = ProjectMO.findOrInsert(using: name, in: context)
        project.name = name
        project.creationDate = dateFormatter.date(from: creationDate) ?? Date()
        project.info = info ?? ""
        project.stage = stage ?? ""
        project.deadline = deadline ?? ""
//        for issue in issues ?? [] {
//            project.addToIssues(issue.toManagedModel(in: context))
//        }
//        for member in team ?? [] {
//            project.addToTeam(member.toManagedModel(in: context))
//        }
        
        return project
    }
}

extension ProjectDM: Identifiable { }

extension ProjectDM: Codable { }
