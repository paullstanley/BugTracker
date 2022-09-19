//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Domain

public struct AddIssue: IAddIssue {
    public let issueRepository: IIssueRepository
    
    public init(issueRepository: IIssueRepository) {
        self.issueRepository = issueRepository
    }
    
    public func execute(_ issue: IssueDM) -> IssueDM? {
        issueRepository.create(issue)
    }
}
