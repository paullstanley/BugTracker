//
//  DeleteIssueViewModel.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class DeleteIssueViewModel: ObservableObject {
    private let repository: IIssueRepository
    @Published var isDeleted: Bool = false
    
    init(storageProvider: StorageProvider) {
        repository = IssueRepository(storageProvider: storageProvider)
    }
    
    func execute(_ issue: IssueDM) {
        isDeleted = DeleteIssueUseCase(issueRepository: repository).execute(issue)
    }
}
