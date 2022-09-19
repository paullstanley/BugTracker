//
//  ProjectMO+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//
import CoreData

@objc(ProjectMO)
public class ProjectMO: NSManagedObject { }

extension ProjectMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectMO> {
        return NSFetchRequest<ProjectMO>(entityName: "ProjectEntity")
    }
    @NSManaged public var identifier: UUID
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
    @NSManaged public var fetchedIssues: [IssueMO]
}

extension ProjectMO {
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "creationDate")
    }
}

extension ProjectMO {
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

extension ProjectMO {
    public static func findOrInsert(using name: String, in context: NSManagedObjectContext)-> ProjectMO {
        let request: NSFetchRequest = NSFetchRequest<ProjectMO>(entityName: "ProjectEntity")

        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)

        if let project: ProjectMO = try? context.fetch(request).first {
            return project
        } else {
            let project: ProjectMO = ProjectMO(context: context)
            project.identifier = UUID()
            project.name = name
            return project
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

extension ProjectMO: Identifiable { }
