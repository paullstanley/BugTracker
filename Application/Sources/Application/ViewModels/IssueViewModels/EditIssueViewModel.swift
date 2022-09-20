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
    
    init() {
        repository = IssueRepository(storageProvider: StorageProvider())
    }
    
    func execute(_ issue: IssueDM)-> IssueDM {
        repository.edit(issue)
    }
}
