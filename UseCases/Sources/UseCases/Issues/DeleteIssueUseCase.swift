//
//  DeleteIssueUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//
import Domain

public struct DeleteIssueUseCase: IDeleteIssueUseCase {
    private let repository: IIssueRepository
    
    public init(repository: IIssueRepository) {
        self.repository = repository
    }
    
    @discardableResult
    public func execute(_ issue: IssueDM) -> Bool {
        repository.delete(issue)
    }
}
