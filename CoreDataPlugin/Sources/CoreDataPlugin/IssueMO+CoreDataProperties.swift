//
//  IssueMO+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//
import CoreData

@objc(IssueMO)
public class IssueMO: NSManagedObject { }

extension IssueMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IssueMO> {
        return NSFetchRequest<IssueMO>(entityName: "IssueEntity")
    }
    @NSManaged public var projectIdentifier: UUID
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
        if let lastModified: Date = lastModified {
            if lastModified.timeIntervalSince(Date()) > 10.0 {
                self.lastModified = Date()
            }
        } else {
            self.lastModified = Date()
        }
    }
}

extension IssueMO {
    public static func findOrInsert(using projectId: UUID, in context: NSManagedObjectContext)-> IssueMO {
        let request: NSFetchRequest = NSFetchRequest<IssueMO>(entityName: "IssueEntity")
        
        request.predicate = NSPredicate(format: "%K == %@", (\IssueMO.projectIdentifier)._kvcKeyPathString!, projectId as NSUUID)
        
        if let issue: IssueMO = try? context.fetch(request).first {
            return issue
        } else {
            let issue: IssueMO = IssueMO(context: context)
            issue.projectIdentifier = projectId
            return issue
        }
    }
}

extension IssueMO : Identifiable {  }
