//
//  IssueEntity+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//

import Foundation
import CoreData

@objc(IssueMO)
public class IssueMO: NSManagedObject { }

extension IssueMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IssueMO> {
        return NSFetchRequest<IssueMO>(entityName: "IssueEntity")
    }
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var creationDate: Date
    @NSManaged public var info: String?
    @NSManaged public var lastModified: String?
    @NSManaged public var project: ProjectMO?
}

extension IssueMO {
    func toDomainModel()-> IssueDM {
        return IssueDM(id: String(describing: id), title: title, type: type, creationDate: creationDate, info: info, lastModified: lastModified)
    }
}

extension IssueMO {
    static func findOrInsert(using title: String, in context: NSManagedObjectContext)-> IssueMO {
        let request = NSFetchRequest<IssueMO>(entityName: "IssueEntity")
        
        request.predicate = NSPredicate(format: "%K == %@", (\IssueMO.title)._kvcKeyPathString!, title as String)
        
        if let issue = try? context.fetch(request).first {
            return issue
        } else {
            let issue = IssueMO(context: context)
            issue.title = title
            return issue
        }
    }
}

extension IssueMO : Identifiable { public var id: NSManagedObjectID { objectID } }
