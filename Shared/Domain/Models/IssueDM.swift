//
//  IssueDM.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData
import CoreDataPlugin

struct IssueDM {
    var id: String = ""
    var title: String
    var type: String?
    var creationDate: String = ""
    var info: String?
    var lastModified: String?
    var project: ProjectDM?
    var projectIdentifier: String? = ""
}

extension IssueDM {
    func toManagedModel(in context: NSManagedObjectContext)-> IssueMO {
        let dateFormatter = DateFormatter()
        
        let issue = IssueMO.init(context: context)
        issue.type = type ?? ""
        issue.title = title
        issue.creationDate = dateFormatter.date(from: creationDate) ?? Date()
        issue.info = info ?? ""
        issue.version = 1
        issue.lastModified = dateFormatter.date(from: lastModified ?? self.creationDate)
        issue.project = project?.toManagedModel(in: context)
        
        return issue
    }
}

extension IssueDM: Identifiable { }

