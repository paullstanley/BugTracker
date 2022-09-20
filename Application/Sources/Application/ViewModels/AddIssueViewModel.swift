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
    private let repository: IssueRepository
    
    @Published var issue: IssueDM = IssueDM(id: UUID().uuidString)
    
    init(storageProvider: StorageProvider) {
        repository = IssueRepository(storageProvider: storageProvider)
    }
    
    func execute() {
        guard let newIssue: IssueDM = AddIssueUseCase(issueRepository: repository).execute(issue) else { return }
        issue = newIssue
    }
}
