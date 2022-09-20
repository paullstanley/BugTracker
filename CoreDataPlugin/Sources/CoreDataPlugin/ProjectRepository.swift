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
        guard let storageProviderContainer = storageProvider.container else { return [] }
        var projectsDM: [ProjectDM] = []
        let request = ProjectMO.fetchRequest()
        do {
            let projectsMO = try storageProviderContainer.viewContext.fetch(request)
            
            projectsDM = projectsMO.map {
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
            return projectsDM
        } catch {
            print("There was an issue fetching the projects")
        }
        return []
    }
    
    public func getByName(_ name: String) -> ProjectDM? {
        guard let storageProviderContainer = storageProvider.container else { return nil }
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)
        request.fetchLimit = 1
        
        guard let selectedProject = try? storageProviderContainer.viewContext.fetch(request) else { return nil }
            return ProjectDM(id: selectedProject.first!.identifier)
    }
    
    public func create(_ _project: ProjectDM) -> ProjectDM? {
        guard let storageProviderContainer = storageProvider.container else { return nil }
        let projectMO = ProjectMO.findOrInsert(using: _project.name, in: storageProviderContainer.viewContext)
        projectMO.identifier = UUID()
        projectMO.name = _project.name
        projectMO.creationDate = Date()
        projectMO.info = _project.info
        projectMO.stage = _project.stage
        projectMO.deadline = _project.deadline
        do {
            if storageProviderContainer.viewContext.hasChanges {
                try storageProviderContainer.viewContext.save()
            }
        } catch {
            storageProviderContainer.viewContext.rollback()
        }
        return ProjectDM(
            id: projectMO.identifier,
            name: projectMO.name,
            creationDate: projectMO.creationDate.formatted(),
            info: projectMO.info ?? "",
            lastModified: projectMO.lastModified?.formatted() ?? "",
            stage: projectMO.stage,
            deadline: projectMO.deadline
        )
    }
    
    public func edit(_ _project: ProjectDM) -> ProjectDM {
        guard let storageProviderContainer = storageProvider.container else { return _project }
        var projectDM = _project
        if let projectMO = getById(_project.id) {
            projectMO.identifier = _project.id
            projectMO.name = _project.name
            projectMO.info = _project.info
            projectMO.creationDate = DateFormatter().date(from: _project.creationDate) ?? projectMO.creationDate
            projectMO.stage = _project.stage
            
            projectDM = ProjectDM(id: projectMO.identifier)
            
            do {
                try storageProviderContainer.viewContext.save()
            } catch {
                print("There was an issue saving the edited issue")
            }
        } else {
            print("There was an issue fetching the the project to edit")
        }
        return projectDM
    }
    
    public func delete(_ _project: ProjectDM) -> Bool {
        guard let storageProviderContext = storageProvider.container?.viewContext else { return false }
        guard let project = getById(_project.id) else { return false }
        
        let context = project.managedObjectContext ?? storageProviderContext
        context.delete(project)
        do {
            if context.hasChanges {
                try context.save()
                _ = getAll()
            }
        } catch {
            context.rollback()
            print("Was unable to save")
        }
        return true
    }
    
    private func getById(_ id: UUID)-> ProjectMO? {
        guard let storageContainer = storageProvider.container else { return nil }
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.identifier), id as NSUUID)
        request.fetchLimit = 1
        guard let projectMO = try? storageContainer.viewContext.fetch(request).first else { return nil }
        return projectMO
    }
}
