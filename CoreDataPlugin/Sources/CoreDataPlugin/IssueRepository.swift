//
//  IssueRepository.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import Domain
import UseCases

public class IssueRepository: IIssueRepository {
    private let storageProvider: StorageProvider
    
    public init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
    }
    
    public func getAll()-> [IssueDM] {
        let request = IssueMO.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let issueModelObjects = try storageProvider.persistentContainer!.viewContext.fetch(request)
            return issueModelObjects.map { IssueDM(id: $0.projectIdentifier.uuidString, title: $0.title, type: $0.type, creationDate: $0.creationDate.formatted(), info: $0.info ?? "", lastModified: $0.lastModified?.formatted() ?? "", project: ProjectDM(id: $0.projectIdentifier), projectIdentifier: $0.projectIdentifier.uuidString) }
        } catch {
            print("There was an issue fetching the issues")
        }
        return []
    }
    
    public func getByName(_ title: String) -> IssueDM? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.title), title as String)
        request.fetchLimit = 1
        if let selectedIssue = try? storageProvider.persistentContainer!.viewContext.fetch(request) {
            return IssueDM(id: selectedIssue.first!.projectIdentifier.uuidString)
        } else {
            return nil
        }
    }
    
    public func create(_ _issue: IssueDM) -> IssueDM? {
        if let issue = getById(UUID(uuidString: _issue.projectIdentifier)!) {
            return IssueDM(id: issue.projectIdentifier.uuidString, title: issue.title, type: issue.type, creationDate: issue.creationDate.formatted(), info: issue.info ?? "", lastModified: issue.lastModified?.formatted() ?? "", project: ProjectDM(id: issue.projectIdentifier), projectIdentifier: issue.projectIdentifier.uuidString)
        } else {
            let issue = IssueMO.findOrInsert(using:UUID(uuidString: _issue.projectIdentifier)!, in: storageProvider.persistentContainer!.viewContext)
            issue.projectIdentifier = UUID(uuidString: _issue.projectIdentifier)!
            issue.title = _issue.title
            issue.creationDate = Date()
            issue.info = _issue.info
            issue.type = _issue.type
            do {
                if storageProvider.persistentContainer!.viewContext.hasChanges {
                    try storageProvider.persistentContainer!.viewContext.save()
                }
            } catch {
                storageProvider.persistentContainer!.viewContext.rollback()
            }
            return IssueDM(id: issue.projectIdentifier.uuidString, title: issue.title, type: issue.type, creationDate: issue.creationDate.formatted(), info: issue.info ?? "", lastModified: issue.lastModified?.formatted() ?? "", project: ProjectDM(id: issue.projectIdentifier), projectIdentifier: issue.projectIdentifier.uuidString)
        }
    }
    
    public func edit(_ _issue: IssueDM) -> IssueDM {
        var issueToEdit = _issue
        if let issue = getById(UUID(uuidString: _issue.projectIdentifier)!) {
            issue.projectIdentifier = UUID(uuidString: _issue.projectIdentifier)!
            issue.title = _issue.title
            issue.info = _issue.info
            issue.creationDate = DateFormatter().date(from:_issue.creationDate) ?? issue.creationDate
            issue.type = _issue.type
            issueToEdit = IssueDM(id: issue.projectIdentifier.uuidString, title: issue.title, type: issue.type, creationDate: issue.creationDate.formatted(), info: issue.info ?? "", lastModified: issue.lastModified?.formatted() ?? "",  projectIdentifier: issue.projectIdentifier.uuidString)
            
            do {
                try storageProvider.persistentContainer!.viewContext.save()
            } catch {
                print("There was an issue saving the edited issue")
            }
        } else {
            print("There was an issue fetching the the issue to edit")
        }
        return issueToEdit
    }
    
    public func delete(_ _issue: IssueDM) -> Bool {
        if let issue = getById(UUID(uuidString:  _issue.projectIdentifier)!) {
            let context = issue.managedObjectContext ?? storageProvider.persistentContainer!.viewContext
            context.delete(issue)
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
    
    private func getById(_ id: UUID)-> IssueMO? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.projectIdentifier), id as NSUUID)
        request.fetchLimit = 1
        if let issue = try? storageProvider.persistentContainer!.viewContext.fetch(request).first {
            return issue
        } else {
            print("Unable to find Issue Entity by provided id - \(id)")
            return nil
        }
    }
}
