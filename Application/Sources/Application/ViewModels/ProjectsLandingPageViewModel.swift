//
//  ProjectsLandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain

class ProjectsLandingPageViewModel: ObservableObject {
    let repository: ProjectRepository
    @Published var isCreateIssueShowing: Bool = false
    @Published var isShowing: Bool = false
    @Published private(set) var projects: [ProjectDM]
    @Published var selection: UUID = UUID()
    @Published var showingCreateProject: Bool = false
    @Published var order: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.stringId, order: SortOrder.forward)
    ]
    
    init(repository: ProjectRepository) {
        self.repository = repository
        projects = repository.getAll()
    }
    
    private var sortedProjects: [ProjectDM] {
        return projects.sorted(using: order)
    }
    
    func getProjects() {
        projects =  repository.getAll()
    }
    
     var selectedProject: ProjectDM  {
         return sortedProjects.first(where: { $0.id == selection }) ??  sortedProjects.first ?? ProjectDM(id: UUID())
    }
    
    
}
