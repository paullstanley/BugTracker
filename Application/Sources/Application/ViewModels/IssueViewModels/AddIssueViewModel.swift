//
//  AddIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import UseCases
import CoreDataPlugin
import Domain

class AddIssueViewModel: ObservableObject {
    private let repository: IIssueRepository
    
    @Published var issue: IssueDM = IssueDM()
    
    init(storageProvider: StorageProvider) {
        self.repository = IssueRepository(storageProvider: storageProvider)
    }
    
    func execute() {
            if let newIssue: IssueDM = AddIssueUseCase(issueRepository: repository).execute(issue) {
                self.issue = newIssue
            }    
        
    }
}
