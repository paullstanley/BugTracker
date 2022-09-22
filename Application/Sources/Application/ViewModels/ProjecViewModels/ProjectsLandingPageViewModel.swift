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
    private let repository: ProjectRepository
    @Published var projectSelection: UUID = UUID()
    @Published var issueSelection: String = ""
    
    @Published var projects: [ProjectDM]
    @Published private(set) var projectIssues: [IssueDM] = []
    
    @Published var projectOrder: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.stringId, order: SortOrder.forward)
    ]
    
    @Published var issueOrder: [KeyPathComparator<IssueDM>] = [
        .init(\IssueDM.id, order: SortOrder.forward)
    ]
    
    @Published var showingCreateIssue: Bool = false
    @Published var showingCreateProject: Bool = false
    
    init(storageProvider: StorageProvider) {
        self.repository = ProjectRepository(storageProvider: storageProvider)
        projects = repository.getAll()
    }
    
    private var sortedProjects: [ProjectDM] {
        return projects.sorted(using: projectOrder)
    }
    
    private var sortedIssues: [IssueDM] {
        return selectedProject.issues?.sorted(using: issueOrder) ?? []
    }
    
    func updateProjectSelection(_ selection: UUID?) {
        guard let newSelection: UUID = selection else { return }
        self.projectSelection = newSelection
    }
    
    func updateIssueSelection(_ selection: String?) {
        guard let newSelection: String = selection else { return }
        self.issueSelection = newSelection
    }
    
    func getProjects() {
        projects =  repository.getAll()
    }
    
    var selectedIssue: IssueDM  {
        return sortedIssues.first(where: { $0.id == issueSelection }) ??  sortedIssues.first ?? IssueDM()
    }
    
    var selectedProject: ProjectDM  {
        return sortedProjects.first(where: { $0.id == projectSelection }) ??  sortedProjects.first ?? ProjectDM(id: UUID())
    }
}
