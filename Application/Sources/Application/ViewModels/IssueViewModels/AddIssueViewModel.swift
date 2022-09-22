//
//  AddIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class AddIssueViewModel: ObservableObject {
    private let repository: IIssueRepository
    let addIssueUseCase: IAddIssueUseCase
    
    @Published var issue: IssueDM = IssueDM(id: UUID().uuidString)
    
    init(storageProvider: StorageProvider) {
        repository = IssueRepository(storageProvider: storageProvider)
        addIssueUseCase = AddIssueUseCase(issueRepository: self.repository)
    }
    
    func execute() {
           guard let newIssue: IssueDM = addIssueUseCase.execute(issue) else { return }
        self.issue = newIssue
    }
}
