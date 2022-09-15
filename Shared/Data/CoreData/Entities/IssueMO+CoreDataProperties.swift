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
    @NSManaged public var projectIdentifier: UUID?
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var creationDate: Date
    @NSManaged public var info: String?
    @NSManaged public var lastModified: Date?
    @NSManaged public var project: ProjectMO?
    @NSManaged public var version: Int
}

extension IssueMO {
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "creationDate")
    }
}

extension IssueMO {
    override public func willSave() {
        if let lastModified = lastModified {
            if lastModified.timeIntervalSince(Date()) > 10.0 {
                self.lastModified = Date()
            }
        } else {
            self.lastModified = Date()
        }
    }
}

extension IssueMO {
    func toDomainModel()-> IssueDM {
        return IssueDM(id: String(describing: id), title: title, type: type, creationDate: creationDate.formatted(), info: info, lastModified: lastModified?.formatted())
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
