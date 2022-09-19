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
    private let repository: ProjectRepository
    @Published var selection: UUID = UUID()
    
    @Published private(set) var projects: [ProjectDM]
    @Published var order: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.stringId, order: SortOrder.forward)
    ]
    
    @Published var showingCreateIssue: Bool = false
    @Published var showingCreateProject: Bool = false
    
    init(repository: ProjectRepository) {
        self.repository = repository
        projects = repository.getAll()
    }
    
    private var sortedProjects: [ProjectDM] {
        return projects.sorted(using: order)
    }
    
    func updateSelecttion(_ selection: UUID?) {
        guard let newSelection: UUID = selection else { return }
        self.selection = newSelection
    }
    
    func getProjects() {
        projects =  repository.getAll()
    }
    
     var selectedProject: ProjectDM  {
         return sortedProjects.first(where: { $0.id == selection }) ??  sortedProjects.first ?? ProjectDM(id: UUID())
    }
    
    
}
