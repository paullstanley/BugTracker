//
//  IssueRepository.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import Domain
import UseCases

public class IssueRepository {
    private let storageProvider: StorageProvider
    
    public init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
    }
}

extension IssueRepository: IIssueRepository {
    public func getAllIssues(for project: ProjectDM)-> [IssueDM] {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return [] }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            guard let projectDMId = UUID(uuidString: project.id) else { return [] }
            let projectMO = ProjectMO.findOrInsert(using: projectDMId, in: context)
            let issuesDM = projectMO.fetchedIssues.map {
                IssueDM(id: $0.identifier.uuidString, title: $0.title, type: $0.type, creationDate: $0.creationDate.formatted(), info: $0.info ?? "", lastModified: $0.lastModified?.formatted() ?? "", project: ProjectDM(id: $0.project.identifier.uuidString), projectIdentifier: $0.project.identifier.uuidString)
            }
            return issuesDM
        }
    }
    
    public func getByName(_ title: String) -> IssueDM? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            let request = IssueMO.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.title), title as String)
            request.fetchLimit = 1
            if let selectedIssueMO = try? storageProvider.persistentContainer!.viewContext.fetch(request) {
                return IssueDM(id: selectedIssueMO.first!.identifier.uuidString)
            } else {
                return nil
            }
        }
    }
    
    public func create(_ _issue: IssueDM, for _project: ProjectDM) -> IssueDM? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        
        let issueIdString = UUID().uuidString
        
        if let issueId = UUID(uuidString: issueIdString)  {
            guard let issueDMsProjectId = UUID(uuidString: _project.id) else {
                fatalError("There was an issue converting the ProjectDNs Id to UUID")
            }
            
            return context.performAndWait {
                let issueMOsProject = ProjectMO.findOrInsert(using: issueDMsProjectId, in: context)
                let issueMO = IssueMO.findOrInsert(using: issueId, for: issueMOsProject, in: context)
                issueMO.identifier = issueId
                issueMO.title = _issue.title
                issueMO.info = _issue.info
                issueMO.type = _issue.type
                issueMO.project = issueMOsProject
                
                do {
                    if context.hasChanges {
                        try context.save()
                    }
                } catch {
                    context.rollback()
                }
                
                return IssueDM(
                    id: issueMO.identifier.uuidString,
                    title: issueMO.title,
                    type: issueMO.type,
                    creationDate: issueMO.creationDate.formatted(),
                    info: issueMO.info ?? "",
                    lastModified: issueMO.lastModified?.formatted() ?? "",
                    project: ProjectDM(id: _project.id),
                    projectIdentifier: _project.id
                )
            }
        }
        return nil
    }
    
    public func edit(_ _issue: IssueDM) -> IssueDM {
        guard let storageProviderContainer = storageProvider.persistentContainer else {
            fatalError("There was an isue accessing the persistentContainer")
        }
        let context = storageProviderContainer.viewContext
        
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
        return issueDM
    }
    
    public func delete(_ _issue: IssueDM) -> Bool {
        guard let storageContainer = storageProvider.persistentContainer else { return false }
        guard let issueId = UUID(uuidString: _issue.id) else { return false }
        guard let issueMO = getById(issueId) else { return false }
        
        let context = issueMO.managedObjectContext ?? storageContainer.viewContext
        do {
            context.delete(issueMO)
            if context.hasChanges {
                try context.save()
            }
        }catch {
            context.rollback()
            print("Was unable to save")
        }
        return true
    }
    
    private func getById(_ id: UUID)-> IssueMO? {
        guard let storageProviderContainer = storageProvider.persistentContainer else { return nil }
        let context = storageProviderContainer.viewContext
        
        return context.performAndWait {
            let request = IssueMO.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", #keyPath(IssueMO.identifier), id as NSUUID)
            request.fetchLimit = 1
            guard let issueMO = try? context.fetch(request).first else { return nil }
            return issueMO
        }
        
    }
}

