//
//  ProjectRepository.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain
import UseCases

public class ProjectRepository: IProjectRepository {
    private let storageProvider: StorageProvider
    
    public init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
    }
    
    public func getAll()-> [ProjectDM] {
        var projects: [ProjectDM] = []
        let request = ProjectMO.fetchRequest()
        do {
            let projectModelObjects = try storageProvider.persistentContainer!.viewContext.fetch(request)
            
            projects = projectModelObjects.map {
                ProjectDM(
                    id: $0.identifier,
                    name: $0.name,
                    creationDate: $0.creationDate.formatted(),
                    info: $0.info ?? "",
                    lastModified: $0.lastModified?.formatted() ?? "",
                    stage: $0.stage, deadline: $0.deadline,
                    issues: $0.fetchedIssues.map {
                        IssueDM(
                            id: $0.identifier.uuidString,
                            title: $0.title,
                            type: $0.type,
                            creationDate: $0.creationDate.formatted(),
                            info: $0.info ?? "",
                            lastModified: $0.lastModified?.formatted() ?? "",
                            projectIdentifier: $0.projectIdentifier.uuidString
                        )})
                
            }
            return projects
        } catch {
            print("There was an issue fetching the projects")
        }
        return []
    }
    
    public func getByName(_ name: String) -> ProjectDM? {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)
        request.fetchLimit = 1
        if let selectedProject = try? storageProvider.persistentContainer!.viewContext.fetch(request) {
            return ProjectDM(id: selectedProject.first!.identifier)
        } else {
            return nil
        }
    }
    
    public func create(_ _project: ProjectDM) -> ProjectDM? {
            let project = ProjectMO.findOrInsert(using: _project.name, in: storageProvider.persistentContainer!.viewContext)
            project.identifier = UUID()
            project.name = _project.name
            project.creationDate = Date()
            project.info = _project.info
            project.stage = _project.stage
            project.deadline = _project.deadline
            do {
                if storageProvider.persistentContainer!.viewContext.hasChanges {
                    try storageProvider.persistentContainer!.viewContext.save()
                }
            } catch {
                storageProvider.persistentContainer!.viewContext.rollback()
            }
            return ProjectDM(
                id: project.identifier,
                name: project.name,
                creationDate: project.creationDate.formatted(),
                info: project.info ?? "",
                lastModified: project.lastModified?.formatted() ?? "",
                stage: project.stage,
                deadline: project.deadline
            )
    }
    
    public func edit(_ _project: ProjectDM) -> ProjectDM {
        var projectToEdit = _project
        if let project = getById(_project.id) {
            project.identifier = _project.id
            project.name = _project.name
            project.info = _project.info
            project.creationDate = DateFormatter().date(from: _project.creationDate) ?? project.creationDate
            project.stage = _project.stage
            
            projectToEdit = ProjectDM(id: project.identifier)
            
            do {
                try storageProvider.persistentContainer!.viewContext.save()
            } catch {
                print("There was an issue saving the edited issue")
            }
        } else {
            print("There was an issue fetching the the project to edit")
        }
        return projectToEdit
    }
    
    public func delete(_ _project: ProjectDM) -> Bool {
        if let project = getById(_project.id) {
            let context = project.managedObjectContext ?? storageProvider.persistentContainer!.viewContext
            context.delete(project)
            print("Deleted successfully")
            do {
                if context.hasChanges {
                    try context.save()
                    _ = getAll()
                    print("Saved successfully")
                }
            } catch {
                context.rollback()
                print("Was unable to save")
            }
            return true
        }
        return false
    }
    
    private func getById(_ id: UUID)-> ProjectMO? {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.identifier), id as NSUUID)
        request.fetchLimit = 1
        if let project = try? storageProvider.persistentContainer!.viewContext.fetch(request).first {
            return project
        } else {
            print("Unable to find Project Entity by provided id - \(id)")
            return nil
        }
    }
}
