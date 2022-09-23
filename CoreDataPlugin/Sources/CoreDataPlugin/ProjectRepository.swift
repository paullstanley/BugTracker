//
//  ProjectRepository.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain
import UseCases

public class ProjectRepository {
    private let storageProvider: StorageProvider
    
    public init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
    }
}

extension ProjectRepository: IProjectRepository {
    public func getAll()-> [ProjectDM] {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return [] }
        let context = storageProviderContainer.viewContext
        
        var projectsDM: [ProjectDM] = []
        
        return context.performAndWait {
            context.reset()
            let request = ProjectMO.fetchRequest()
            do {
                let projectsMO = try context.fetch(request)
                
                projectsDM = projectsMO.map {
                    ProjectDM(
                        id: $0.identifier.uuidString,
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
                                lastModified: $0.lastModified?.formatted() ?? ""
                            )})
                }
                return projectsDM
            } catch {
                print("There was an issue fetching the projects")
            }
            return []
        }
    }
    
    public func getByName(_ name: String) -> ProjectDM? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            let request = ProjectMO.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)
            request.fetchLimit = 1
            
            guard let selectedProject = try? context.fetch(request) else { return nil }
            guard let returnedProject = selectedProject.first else { return nil}
            return ProjectDM(id: returnedProject.identifier.uuidString)
        }
    }
    
    public func create(_ _project: ProjectDM) -> ProjectDM? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        let projectDMId = UUID()
        
        return context.performAndWait {
            let projectMO = ProjectMO.findOrInsert(using: projectDMId, in: context)
            projectMO.identifier = UUID()
            projectMO.name = _project.name
            projectMO.creationDate = Date()
            projectMO.info = _project.info
            projectMO.stage = _project.stage
            projectMO.deadline = _project.deadline
            do {
                if context.hasChanges {
                    try context.save()
                }
                return ProjectDM(
                    id: projectMO.identifier.uuidString,
                    name: projectMO.name,
                    creationDate: projectMO.creationDate.formatted(),
                    info: projectMO.info ?? "",
                    lastModified: projectMO.lastModified?.formatted() ?? "",
                    stage: projectMO.stage,
                    deadline: projectMO.deadline
                )
            } catch {
                context.rollback()
            }
                return nil
        }

    }
    
    public func edit(_ _project: ProjectDM) -> ProjectDM {
        guard let projectDMId = UUID(uuidString: _project.id) else {
            fatalError("There was an issue converting the ProjectDMs Id to UUID")
        }
        
        guard let storageProviderContainer = storageProvider.persistentContainer else {
            fatalError("There was an isue accessing the persistentContainer")
        }
        let context = storageProviderContainer.viewContext
        
        var projectDM = _project
        if let projectMO = getById(projectDMId) {
            
            projectMO.identifier = projectDMId
            projectMO.name = _project.name
            projectMO.info = _project.info
            projectMO.creationDate = DateFormatter().date(from: _project.creationDate) ?? projectMO.creationDate
            projectMO.stage = _project.stage
            
            projectDM = ProjectDM(id: projectMO.identifier.uuidString)
            context.performAndWait {
                do {
                    if context.hasChanges {
                        try context.save()
                    }
                } catch {
                    context.rollback()
                    print("There was an issue saving the edited issue")
                }
            }
        } else {
            print("There was an issue fetching the the project to edit")
        }
        return projectDM
    }
    
    public func delete(_ _project: ProjectDM) -> Bool {
        guard let projectDMId = UUID(uuidString: _project.id) else { return false }
        guard let storageProviderContainer = storageProvider.persistentContainer else { return false }
        let context = storageProviderContainer.viewContext
        
        guard let project = getById(projectDMId) else { return false }
        
        context.performAndWait {
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
        }
        return true
    }
    
    private func getById(_ id: UUID)-> ProjectMO? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            let request = ProjectMO.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.identifier), id as NSUUID)
            request.fetchLimit = 1
            guard let projectMO = try? context.fetch(request).first else { return nil }
            return projectMO
        }
       
    }
    public func getAllIssues(for project: ProjectDM)-> [IssueDM] {
        print("##################################################")
        guard let projectDMId = UUID(uuidString: project.id) else { return [] }
        guard let storageProviderContainer = storageProvider.persistentContainer else { return [] }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            let projectMO = ProjectMO.findOrInsert(using: projectDMId, in: context)
        
            let issuesDM = projectMO.fetchedIssues.map {
                IssueDM(id: $0.identifier.uuidString, title: $0.title, type: $0.type, creationDate: $0.creationDate.formatted(), info: $0.info ?? "", lastModified: $0.lastModified?.formatted() ?? "", projectIdentifier: projectMO.identifier.uuidString)
            }
            context.reset()
            print("##################################################")
            print(issuesDM)
            return issuesDM
        }
    }
}
