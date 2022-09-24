//
//  AddIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import Domain
import UseCases

class AddIssueViewModel: ObservableObject {
    private let addIssueUseCase: IAddIssueUseCase
    
    @Published var issue: IssueDM = IssueDM(id: UUID().uuidString)
    
    init(repository: IIssueRepository) {
        addIssueUseCase = AddIssueUseCase(repository: repository)
    }
    
    func execute() {
        guard let newIssue: IssueDM = addIssueUseCase.execute(issue) else { return }
        self.issue = newIssue
    }
}
