//
//  EditIssueUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct EditIssueUseCase: IEditIssueUseCase {
    private let repository: IIssueRepository
    
    public init(repository: IIssueRepository) {
        self.repository = repository
    }
    
    public func execute(_ issue: IssueDM) -> IssueDM? {
        repository.edit(issue)
    }
}
