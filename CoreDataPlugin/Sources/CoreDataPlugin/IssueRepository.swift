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
            let issuesMO = try storageProvider.peristentContainer!.viewContext.fetch(request)
            
            return issuesMO.map {
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
        if let selectedIssueMO = try? storageProvider.peristentContainer!.viewContext.fetch(request) {
            return IssueDM(id: selectedIssueMO.first!.projectIdentifier.uuidString)
        } else {
            return nil
        }
    }
    
    public func create(_ _issue: IssueDM) -> IssueDM? {
        guard let storageContainer = storageProvider.peristentContainer else { return nil }
        let projectMO = ProjectMO.findOrInsert(using: _issue.project!.name, in: storageContainer.viewContext)
        if let issueId = UUID(uuidString: _issue.id)  {
            let issueMO = IssueMO.findOrInsert(using: issueId, for: projectMO, in: storageContainer.viewContext)
            issueMO.projectIdentifier = projectMO.identifier
            issueMO.title = _issue.title
            issueMO.creationDate = Date()
            issueMO.info = _issue.info
            issueMO.type = _issue.type
            issueMO.project = projectMO
            do {
                if storageContainer.viewContext.hasChanges {
                    try storageContainer.viewContext.save()
                }
            } catch {
                storageContainer.viewContext.rollback()
            }
            return IssueDM(
                id: issueMO.projectIdentifier.uuidString,
                title: issueMO.title,
                type: issueMO.type,
                creationDate: issueMO.creationDate.formatted(),
                info: issueMO.info ?? "",
                lastModified: issueMO.lastModified?.formatted() ?? "",
                project: ProjectDM(id: issueMO.projectIdentifier),
                projectIdentifier: issueMO.projectIdentifier.uuidString
            )
        }
        return nil
    }
    
    public func edit(_ _issue: IssueDM) -> IssueDM {
        guard let storageContainer = storageProvider.peristentContainer else {
            fatalError("There was an isue accessing the persistentContainer")
        }
        var issueDM = _issue
        guard let issueId = UUID(uuidString: _issue.id) else { return _issue}
        guard let issueMO = getById(issueId) else { return _issue }
            issueMO.identifier = issueId
            issueMO.title = _issue.title
            issueMO.info = _issue.info
            issueMO.type = _issue.type
            issueMO.creationDate = DateFormatter().date(from: _issue.creationDate) ?? issueMO.creationDate
            issueMO.lastModified = Date()
            
            issueDM = IssueDM(id: issueMO.identifier.uuidString)
            do {
                try storageContainer.viewContext.save()
                
            } catch {
                print("There was an issue saving the edited issue")
            }
            return issueDM
        }
    
    public func delete(_ _issue: IssueDM) -> Bool {
        guard let storageContainer = storageProvider.peristentContainer else { return false }
        guard let issueId = UUID(uuidString: _issue.id) else { return false }
        guard let issueMO = getById(issueId) else { return false }
        
        let context = issueMO.managedObjectContext ?? storageContainer.viewContext
        do {
            context.delete(issueMO)
            if context.hasChanges {
                try context.save()
                _ = getAll()
            }
        }catch {
            context.rollback()
            print("Was unable to save")
        }
        return true
    }
    
    private func getById(_ id: UUID)-> IssueMO? {
        guard let storageContainer = storageProvider.peristentContainer else { return nil }
        let request = IssueMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.identifier), id as NSUUID)
        request.fetchLimit = 1
        guard let issueMO = try? storageContainer.viewContext.fetch(request).first else { return nil }
            return issueMO
    }
}
