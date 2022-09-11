//
//  ProjectRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

class ProjectRepository: IProjectRepository, ObservableObject {
    var storageProvider: CoreDataStack
    
    init(_storageProvider: CoreDataStack) {
       // let mockData = MockCoreData()
        storageProvider = _storageProvider
        
        //mockData.populateDB(context: storageProvider.persistentContainer.newBackgroundContext())
        
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
    
    func create(_ project: ProjectDM) -> ProjectDM? {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), (project.name) as String)
       
        
        if let project = try? storageProvider.persistentContainer.viewContext.fetch(request).first {
            return project.toDomainModel()
        } else {
            let project = project.toManagedModel(in: storageProvider.persistentContainer.viewContext)
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
        let projectMO = _project.toManagedModel(in: storageProvider.childViewContext())
        let project = storageProvider.persistentContainer.viewContext.object(with: projectMO.objectID) as! ProjectMO
            project.name = "fart"
            project.creationDate = DateFormatter().date(from: _project.creationDate) ?? Date()
            project.stage = _project.stage ?? ""
            project.deadline = _project.deadline ?? ""
            do {
                try storageProvider.persistentContainer.viewContext.save()
               // return project.toDomainModel()
            } catch {
                
            }
        print("There was an issue finding the entity to be edited")
        return _project
    }
    
    func delete(_ project: ProjectDM) -> Bool {
        let request = ProjectMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), (project.name) as String)
        request.fetchLimit = 1
        if let project = try? storageProvider.persistentContainer.viewContext.fetch(request).first {
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
}
