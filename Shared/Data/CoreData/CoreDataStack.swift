//
//  CoreDataStack.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/6/22.
//

import CoreData

public class CoreDataStack {
    public let persistentContainer: NSPersistentContainer
    
    public init() {
        persistentContainer = try! startPersistentContainer()
    }
    
    public func childViewContext()-> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = persistentContainer.viewContext
        return context
    }
}

public extension CoreDataStack {
    func saveProject(named name: String) {
        let bgContext = persistentContainer.newBackgroundContext()
        bgContext.perform {
            let project = ProjectMO(context: bgContext)
            project.name = name
            project.creationDate = Date()
            project.deadline = "Some time"
            project.stage = "Planning"
        }
        do {
            if bgContext.hasChanges {
                try bgContext.save()
            }
        } catch {
            bgContext.rollback()
        }
    }
}

public extension CoreDataStack {
    func fetchAllProjects()-> [ProjectMO] {
        let request: NSFetchRequest<ProjectMO> = ProjectMO.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Failed to fetch projects: \(error)")
            return []
        }
    }
}

