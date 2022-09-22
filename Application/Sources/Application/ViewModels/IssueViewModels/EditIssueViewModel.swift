//
//  EditIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class EditIssueViewModel: ObservableObject {
    private let repository: IIssueRepository
    
    @Published var issueToEdit: IssueDM?
    
    init(storageProvider: StorageProvider) {
        repository = IssueRepository(storageProvider: storageProvider)
    }
    
    func execute(_ issue: IssueDM)-> IssueDM {
        issueToEdit = repository.edit(issue)
        guard let editedIssue = issueToEdit else { return issue }
        return editedIssue
    }
}
