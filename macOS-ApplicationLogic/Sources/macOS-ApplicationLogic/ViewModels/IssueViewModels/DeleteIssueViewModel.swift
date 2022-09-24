//
//  DeleteIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import Foundation
import Domain
import UseCases

class DeleteIssueViewModel: ObservableObject {
    private let deleteIssueUseCase: IDeleteIssueUseCase
    
    @Published var isDeleted: Bool = false
    
    init(repository: IIssueRepository) {
        deleteIssueUseCase = DeleteIssueUseCase(repository: repository)
    }
    
    func execute(_ issue: IssueDM) {
        isDeleted = deleteIssueUseCase.execute(issue)
    }
}
