//
//  ProjectRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import StorageProvider
import CoreData

class ProjectRepository: IProjectRepository, ObservableObject {
    var storageProvider: StorageProvider
    
    init(_storageProvider: StorageProvider) {
         //let mockData = MockCoreData()
        storageProvider = _storageProvider
        
       // mockData.populateDB(context: storageProvider.persistentContainer.newBackgroundContext())
        
    }
    
    func getAll()-> [ProjectDM] {
        let request = ProjectMO.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let projectModelObjects = try storageProvider.persistentContainer.viewContext.fetch(request)
            return projectModelObjects.map { $0.toDomainModel() }
        } catch {
            print("There was an issue fetching the projects")
        }
        return []
    }
    
    func getByName(_ name: String) -> ProjectDM? {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), name as String)
        request.fetchLimit = 1
        if let selectedProject = try? storageProvider.persistentContainer.viewContext.fetch(request) {
            return selectedProject.first?.toDomainModel()
        } else {
            return nil
        }
    }
    
    func create(_ _project: ProjectDM) -> ProjectDM? {
        if let project = getById(_project.id) {
            return project.toDomainModel()
        } else {
            let project = _project.toManagedModel(in: storageProvider.persistentContainer.viewContext)
            do {
                if storageProvider.persistentContainer.viewContext.hasChanges {
                    try storageProvider.persistentContainer.viewContext.save()
                }
            } catch {
                storageProvider.persistentContainer.viewContext.rollback()
            }
            return project.toDomainModel()
        }
    }
    
    func edit(_ _project: ProjectDM) -> ProjectDM {
        var projectToEdit = _project
        if let project = getById(_project.id) {
            project.id = _project.id
            project.name = _project.name
            project.info = _project.info
            project.creationDate = DateFormatter().date(from:_project.creationDate) ?? project.creationDate
            project.stage = _project.stage ?? project.stage
            projectToEdit = project.toDomainModel()
            
            do {
                try storageProvider.persistentContainer.viewContext.save()
            } catch {
                print("There was an issue saving the edited issue")
            }
            
        } else {
            print("There was an issue fetching the the project to edit")
        }
        return projectToEdit
    }
    
    func delete(_ _project: ProjectDM) -> Bool {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.id), _project.id as NSUUID)
        request.fetchLimit = 1
        if let project = getById(_project.id) {
            storageProvider.persistentContainer.viewContext.delete(project)
            do {
                if storageProvider.persistentContainer.viewContext.hasChanges {
                    try storageProvider.persistentContainer.viewContext.save()
                }
                
            } catch {
                storageProvider.persistentContainer.viewContext.rollback()
            }
            
            return true
        }
        return false
    }
    
    private func getById(_ id: UUID)-> ProjectMO? {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.id), id as NSUUID)
        request.fetchLimit = 1
        if let project = try? storageProvider.persistentContainer.viewContext.fetch(request).first {
            return project
        } else {
            print("Unable to find Project Entity by provided id - \(id)")
            return nil
        }
    }
}

extension ProjectRepository {
    
    func updateIssue(for _project: ProjectDM, _issue: IssueDM) {
        let issuesProject = getById(_project.id)!
        let context = storageProvider.persistentContainer.viewContext
            context.perform {
            if issuesProject.fetchedIssues.isEmpty {
                let issue = IssueMO(context: context)
                issue.projectIdentifier = issuesProject.id
                issue.title = _issue.title
                issue.info = _issue.info
                issue.type = _issue.type ?? ""
            } else if let issue = issuesProject.issues?.first {
                issue.title = _issue.title
                issue.info = _issue.info
                issue.type = _issue.type ?? ""
            }
            
            do {
                try context.save()
                context.refresh(issuesProject, mergeChanges: true)
            } catch {
                print("Something went wrong: \(error)")
                context.rollback()
            }
        }
    }
    
    func createIssue(_ issue: IssueDM)-> IssueDM? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.title), issue.title)
        
        if let issue = try? storageProvider.persistentContainer.viewContext.fetch(request).first {
            return issue.toDomainModel()
        } else {
            let issue = issue.toManagedModel(in: storageProvider.persistentContainer.viewContext)
            do {
                if storageProvider.persistentContainer.viewContext.hasChanges {
                    try storageProvider.persistentContainer.viewContext.save()
                }
            } catch {
                storageProvider.persistentContainer.viewContext.rollback()
            }
            return issue.toDomainModel()
        }
    }
}
