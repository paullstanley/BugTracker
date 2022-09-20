//
//  DeleteIssueUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//
import Domain

public struct DeleteIssueUseCase: IDeleteIssueUseCase {
    private let issueRepository: IIssueRepository
    
    public init(issueRepository: IIssueRepository) {
        self.issueRepository = issueRepository
    }
    
    public func execute(_ issue: IssueDM) -> Bool {
        issueRepository.delete(issue)
    }
}
