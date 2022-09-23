//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/23/22.
//

import Foundation
import Domain
import UseCases

class IssueListViewModel: ObservableObject {
    let viewAllIssuesUseCase: IViewIssuesByProjectUseCase
    let deleteIssueUseCase: IDeleteIssueUseCase
    
    @Published var issues: [IssueDM] = []
    
    init(repository: IIssueRepository) {
        viewAllIssuesUseCase = ViewIssuesByProjectUseCase(repository: repository)
        deleteIssueUseCase = DeleteIssueUseCase(repository: repository)
        
    }
    
    func deleteIssue(_ issue: IssueDM)-> Bool {
        if deleteIssueUseCase.execute(issue) {
            getIssues(for: issue.project!)
            return true
        }
        return false
    }
    
    func getIssues(for project: ProjectDM) {
        if !issues.isEmpty {
            issues = viewAllIssuesUseCase.execute(project)
        }
    }
}
