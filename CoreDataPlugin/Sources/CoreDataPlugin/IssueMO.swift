//
//  IssueMO+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//
import CoreData

public class IssueMO: NSManagedObject { }

extension IssueMO {
    public class func fetchRequest() -> NSFetchRequest<IssueMO> {
        return NSFetchRequest<IssueMO>(entityName: "IssueEntity")
    }
    @NSManaged public var identifier: UUID
    @NSManaged public var projectIdentifier: UUID
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var creationDate: Date
    @NSManaged public var info: String?
    @NSManaged public var lastModified: Date?
    @NSManaged public var project: ProjectMO
    @NSManaged public var version: Int
}

extension IssueMO {
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "creationDate")
        setPrimitiveValue(UUID(), forKey: "identifier")
    }
}

extension IssueMO {
    enum ValidationError: Error {
        case invalidName(String)
    }
    
    public override func validateForInsert() throws {
        try super.validateForInsert()
        
        if  title.isEmpty {
            throw ValidationError.invalidName("Title show be a non-empty string")
        }
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
    public static func findOrInsert(using identifier: UUID, for project: ProjectMO, in context: NSManagedObjectContext)-> IssueMO {
        let request: NSFetchRequest = NSFetchRequest<IssueMO>(entityName: "IssueEntity")
        
        request.predicate = NSPredicate(format: "%K == %@", (\IssueMO.identifier)._kvcKeyPathString!, identifier as NSUUID)
        
        if let issue: IssueMO = try? context.fetch(request).first {
            return issue
        } else {
            let issue: IssueMO = IssueMO(context: context)
            issue.project = project
            return issue
        }
    }
}

extension IssueMO : Identifiable {  }
