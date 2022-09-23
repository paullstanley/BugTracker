//
//  EditIssueUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct EditIssueUseCase: IEditIssueUseCase {
    private let issueRepository: IIssueRepository
    
    public init(issueRepository: IIssueRepository) {
        self.issueRepository = issueRepository
    }
    
    @discardableResult
    public func execute(_ issue: IssueDM) -> IssueDM? {
        issueRepository.edit(issue)
    }
}
