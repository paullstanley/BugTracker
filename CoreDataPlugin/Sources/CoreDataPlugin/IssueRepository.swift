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
        do {
            let issueModelObjects = try storageProvider.container!.viewContext.fetch(request)
            
            return issueModelObjects.map {
                IssueDM(
                    id: $0.identifier.uuidString,
                    title: $0.title,
                    type: $0.type,
                    creationDate: $0.creationDate.formatted(),
                    info: $0.info ?? "",
                    lastModified: $0.lastModified?.formatted() ?? "",
                    projectIdentifier: $0.projectIdentifier.uuidString
                )}
        } catch {
            print("There was an issue fetching the issues")
        }
        return []
    }
    
    public func getByName(_ title: String) -> IssueDM? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.title), title as String)
        request.fetchLimit = 1
        if let selectedIssue = try? storageProvider.container!.viewContext.fetch(request) {
            return IssueDM(id: selectedIssue.first!.projectIdentifier.uuidString)
        } else {
            return nil
        }
    }
    
    public func create(_ _issue: IssueDM) -> IssueDM? {
        let projectMO = ProjectMO.findOrInsert(using: _issue.project!.name, in: storageProvider.container!.viewContext)
        if let issueId = UUID(uuidString: _issue.id)  {
            let issue = IssueMO.findOrInsert(using: issueId, for: projectMO, in: storageProvider.container!.viewContext)
            issue.projectIdentifier = projectMO.identifier
            issue.title = _issue.title
            issue.creationDate = Date()
            issue.info = _issue.info
            issue.type = _issue.type
            issue.project = projectMO
            do {
                if storageProvider.container!.viewContext.hasChanges {
                    try storageProvider.container!.viewContext.save()
                }
            } catch {
                storageProvider.container!.viewContext.rollback()
            }
            return IssueDM(
                id: issue.projectIdentifier.uuidString,
                title: issue.title,
                type: issue.type,
                creationDate: issue.creationDate.formatted(),
                info: issue.info ?? "",
                lastModified: issue.lastModified?.formatted() ?? "",
                project: ProjectDM(id: issue.projectIdentifier),
                projectIdentifier: issue.projectIdentifier.uuidString
            )
        }
        return nil
    }
    
    public func edit(_ _issue: IssueDM) -> IssueDM {
        var issueToEdit = _issue
        guard let issueId = UUID(uuidString: _issue.id) else { return _issue}
        if let issue = getById(issueId) {
            issue.identifier = issueId
            issue.title = _issue.title
            issue.info = _issue.info
            issue.type = _issue.type
            issue.creationDate = DateFormatter().date(from: _issue.creationDate) ?? issue.creationDate
            issue.lastModified = Date()
            
            issueToEdit = IssueDM(id: issue.identifier.uuidString)
            do {
                try storageProvider.container!.viewContext.save()
                
            } catch {
                print("There was an issue saving the edited issue")
            }
        } else {
            print("There was an issue fetching the the issue to edit")
        }
        return issueToEdit
    }
    
    public func delete(_ _issue: IssueDM) -> Bool {
        if let issue = getById(UUID(uuidString:  _issue.id)!) {
            let context = issue.managedObjectContext ?? storageProvider.container!.viewContext
            context.delete(issue)
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
        return false
    }
    
    private func getById(_ id: UUID)-> IssueMO? {
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.identifier), id as NSUUID)
        request.fetchLimit = 1
        if let issue = try? storageProvider.container!.viewContext.fetch(request).first {
            return issue
        } else {
            print("Unable to find Issue Entity by provided id - \(id)")
            return nil
        }
    }
}
