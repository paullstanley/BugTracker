//
//  UserMO+CoreDataProperties.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/6/22.
//
//

import Foundation
import CoreData

@objc(UserMO)
public class UserMO: NSManagedObject { }

extension UserMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserEntity")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String
    @NSManaged public var projects: Set<ProjectMO>?
}

extension UserMO {
    func toDomainModel()-> UserDM {
        return UserDM(id: String(describing: id), password: password, username: username, projects: [])
    }
}

extension UserMO {
    static func findOrInsert(using username: String, in context: NSManagedObjectContext)-> UserMO {
        let request = NSFetchRequest<UserMO>(entityName: "UserEntity")
        
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(UserMO.username), username as String)
        
        if let userInfo = try? context.fetch(request).first {
            return userInfo
        } else {
            let userInfo = UserMO(context: context)
            userInfo.username = username
            return userInfo
        }
    }
}

extension UserMO {
    public var sortedProjects: Array<ProjectMO> {
        return Array(projects ?? []).sorted { lhs, rhs in
            return rhs.name > lhs.name
        }
    }
}

// MARK: Generated accessors for projects
extension UserMO {
    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: ProjectMO)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: ProjectMO)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: Set<ProjectMO>)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: Set<ProjectMO>)
}

extension UserMO : Identifiable {  public var id: NSManagedObjectID { objectID } }
