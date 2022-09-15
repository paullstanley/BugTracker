//
//  ProjectEntity+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//

import Foundation
import CoreData

@objc(ProjectMO)
public class ProjectMO: NSManagedObject {

}

extension ProjectMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectMO> {
        return NSFetchRequest<ProjectMO>(entityName: "ProjectEntity")
    }
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var creationDate: Date
    @NSManaged public var lastModified: Date?
    @NSManaged public var info: String?
    @NSManaged public var stage: String
    @NSManaged public var deadline: String
    @NSManaged public var issues: Set<IssueMO>?
    @NSManaged public var version: Int
}

extension ProjectMO {
    @NSManaged var fetchedIssues: [IssueMO]
}

extension ProjectMO {
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "creationDate")
    }
}

extension ProjectMO {
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

extension ProjectMO {
    static func findOrInsert(using name: String, in context: NSManagedObjectContext)-> ProjectMO {
        let request = NSFetchRequest<ProjectMO>(entityName: "ProjectEntity")
        
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)
        
        if let project = try? context.fetch(request).first {
            return project
        } else {
            let project = ProjectMO(context: context)
            project.id = UUID()
            project.name = name
            return project
        }
    }
}

extension ProjectMO {
    func toDomainModel()-> ProjectDM {
        return ProjectDM(id: id, name: name, creationDate: creationDate.formatted(), info: info, lastModified: lastModified?.formatted(), stage: stage, deadline: deadline, issues: sortedIssues.map { $0.toDomainModel() })
        
    }
}



extension ProjectMO {
    public var sortedIssues: Array<IssueMO> {
        return Array(issues ?? []).sorted { lhs, rhs in
            return rhs.id > lhs.id
        }
    }
}

// MARK: Generated accessors for issues
extension ProjectMO {
    @objc(addIssuesObject:)
    @NSManaged public func addToIssues(_ value: IssueMO)

    @objc(removeIssuesObject:)
    @NSManaged public func removeFromIssues(_ value: IssueMO)

    @objc(addIssues:)
    @NSManaged public func addToIssues(_ values: Set<IssueMO>)

    @objc(removeIssues:)
    @NSManaged public func removeFromIssues(_ values: Set<IssueMO>)
}
