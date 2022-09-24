//
//  ProjectsLandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class ProjectsLandingPageViewModel: ObservableObject {
    private let viewAllProjectsUseCase: IViewAllProjectsUseCase
    @Published var projectSelection: String? = ""
    @Published var issueSelection: String = ""
    
    @Published var projects: [ProjectDM]
    
    @Published var projectIssues: [IssueDM] = []
    
    @Published var projectOrder: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.id, order: SortOrder.forward)
    ]
    
    @Published var issueOrder: [KeyPathComparator<IssueDM>] = [
        .init(\IssueDM.id, order: SortOrder.forward)
    ]
    
    @Published var showingCreateIssue: Bool = false
    @Published var showingCreateProject: Bool = false
    
    init(repository: IProjectRepository) {
        viewAllProjectsUseCase = ViewAllProjectsUseCase(repository: repository)
        projects = repository.getAll()
    }
    
    public var sortedProjects: [ProjectDM] {
        return projects.sorted(using: projectOrder)
    }
    
    public var sortedIssues: [IssueDM] {
        return projectIssues.sorted(using: issueOrder)
    }
    
    func updateIssueSelection(_ selection: String?) {
        guard let newSelection: String = selection else { return }
        issueSelection = newSelection
    }
    
    func getProjects() {
        projects = viewAllProjectsUseCase.execute()
        projectIssues = selectedProject.issues
    }
    
    var selectedIssue: IssueDM  {
        return sortedIssues.first(where: { $0.id == issueSelection }) ??  sortedIssues.first ?? IssueDM()
    }
    
    var selectedProject: ProjectDM  {
        return sortedProjects.first(where: { $0.id == projectSelection }) ??  sortedProjects.first ?? ProjectDM()
    }
}
