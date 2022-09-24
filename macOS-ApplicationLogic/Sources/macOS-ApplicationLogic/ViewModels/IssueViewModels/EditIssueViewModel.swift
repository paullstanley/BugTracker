//
//  EditIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import Foundation
import Domain
import UseCases

class EditIssueViewModel: ObservableObject {
    private let editIssueUseCase: IEditIssueUseCase
    
    @Published var issueToEdit: IssueDM?
    
    init(repository: IIssueRepository) {
        editIssueUseCase = EditIssueUseCase(repository: repository)
    }
    
    func execute(_ issue: IssueDM)-> IssueDM {
        issueToEdit = editIssueUseCase.execute(issue)
        guard let editedIssue = issueToEdit else { return issue }
        return editedIssue
    }
}
