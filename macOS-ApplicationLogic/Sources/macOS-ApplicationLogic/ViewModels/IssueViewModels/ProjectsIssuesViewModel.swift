//
//  ProjectsIssuesViewModel.swift
//  
//
//  Created by Paull Stanley on 9/22/22.
//

import Foundation
import Domain
import UseCases

class ProjectsIssuesViewModel: ObservableObject {
    private let viewIssuesByProjectUseCase: IViewIssuesByProjectUseCase
    
    @Published var projectIssues: [IssueDM] = []
    
    init(repository: IIssueRepository) {
        viewIssuesByProjectUseCase = ViewIssuesByProjectUseCase(repository: repository)
    }
    
    func execute(_ project: ProjectDM)-> [IssueDM] {
        let issues = viewIssuesByProjectUseCase.execute(project)
        Task {
            DispatchQueue.main.async {
                self.projectIssues = issues
            }
        }
        return issues
    }
}
