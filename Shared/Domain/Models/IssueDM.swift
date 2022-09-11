//
//  IssueDM.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

struct IssueDM {
    var id: String = ""
    var title: String
    var type: String?
    var creationDate: Date = Date()
    var info: String?
    var lastModified: String?
    var project: ProjectDM?
}

extension IssueDM {
    func toManagedModel(in context: NSManagedObjectContext)-> IssueMO {
        let issue = IssueMO.init(context: context)
        issue.type = type ?? ""
        issue.title = title
        issue.creationDate = creationDate
        issue.info = info ?? ""
        issue.lastModified = lastModified ?? ""
        issue.project = project?.toManagedModel(in: context)
        
        return issue
    }
}

extension IssueDM: Identifiable { }

extension IssueDM: Codable { }
