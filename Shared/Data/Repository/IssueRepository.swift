//
//  IssueRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import Foundation
import StorageProvider

class IssueRepository: ObservableObject {
    var storageProvider: StorageProvider
    
    init(_storageProvider: StorageProvider) {
        storageProvider = _storageProvider
    }
    
    func getAll()-> [IssueDM] {
        let request = IssueMO.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            let issueModelObjects = try storageProvider.persistentContainer.viewContext.fetch(request)
            return issueModelObjects.map { $0.toDomainModel() }
        } catch {
            print("There was an issue fetching the issues")
        }
        return []
    }
    
    func getAllForProject(_ projectName: String)-> [IssueDM] {
        let request = ProjectMO.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(ProjectMO.name), projectName as String)
        request.fetchLimit = 1
        request.predicate = predicate
        if let selectedProject = try? storageProvider.persistentContainer.viewContext.fetch(request) {
            return selectedProject.first?.sortedIssues.map { $0.toDomainModel() } ?? []
        }
        return []
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
