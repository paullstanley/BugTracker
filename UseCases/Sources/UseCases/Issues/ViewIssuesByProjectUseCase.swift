//
//  ViewIssuesByProjectUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct ViewIssuesByProjectUseCase: IViewIssuesByProjectUseCase {
    private let repository: IIssueRepository
    
    public init(repository: IIssueRepository) {
        self.repository = repository
    }
    
    public func execute(_ project: ProjectDM) -> [IssueDM] {
        repository.getAllIssues(for: project)
    }
}
