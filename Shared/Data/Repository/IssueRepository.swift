//
//  IssueRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import Foundation
import CoreDataPlugin
import Domain

class IssueRepository: ObservableObject {
    var storageProvider: StorageProvider
    
    init(_storageProvider: StorageProvider) {
        storageProvider = _storageProvider
    }
    
    func getAll()-> [IssueDM] {
        let request = IssueMO.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            let issueModelObjects = try storageProvider.persistentContainer!.viewContext.fetch(request)
            return issueModelObjects.map { IssueDM(title: $0.title) }
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
        if let selectedProject = try? storageProvider.persistentContainer!.viewContext.fetch(request).first {
            
            return selectedProject.fetchedIssues.map { IssueDM(title: $0.title) }
        }
        return []
    }
    
    func createIssue(_ issue: IssueDM)-> IssueDM? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.title), issue.title)
        
        if let issue = try? storageProvider.persistentContainer!.viewContext.fetch(request).first {
            return IssueDM(title: issue.title)
        } else {
            let issue = IssueMO.findOrInsert(using: issue.title, in: storageProvider.persistentContainer!.viewContext)
            do {
                if storageProvider.persistentContainer!.viewContext.hasChanges {
                    try storageProvider.persistentContainer!.viewContext.save()
                }
            } catch {
                storageProvider.persistentContainer!.viewContext.rollback()
            }
            return IssueDM(title: issue.title)
        }
    }
 }
