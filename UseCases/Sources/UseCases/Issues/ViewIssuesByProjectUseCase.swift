//
//  ViewIssuesByProjectUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct ViewIssuesByProjectUseCase: IViewIssuesByProjectUseCase {
    private let issueRepository: IIssueRepository
    
    public init(issueRepository: IIssueRepository) {
        self.issueRepository = issueRepository
    }
    public func execute(_ project: ProjectDM) -> [IssueDM] {
        issueRepository.getAllIssues(for: project)
    }
}
