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
            issues = viewAllIssuesUseCase.execute(ProjectDM(id: issue.projectIdentifier))
            return true
        }
        return false
    }
    
    func getIssues(for project: ProjectDM) {
            issues = viewAllIssuesUseCase.execute(project)
    }
}
