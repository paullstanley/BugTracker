//
//  AddIssueUseCase.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Domain

public struct AddIssueUseCase: IAddIssueUseCase {
    private let repository: IIssueRepository
    
    public init(repository: IIssueRepository) {
        self.repository = repository
    }
    
    public func execute(_ issue: IssueDM) -> IssueDM? {
        print("HELLLLLLLLLLOOOOOOOOOOOOO")
        print(issue.project?.id)
        guard let project = issue.project else { return nil }
        return repository.create(issue, for: project)
    }
}
