//
//  ProjectsLandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class ProjectsLandingPageViewModel: ObservableObject {
    let dataSource: ProjectRepository
    @Published private(set) var projects: [ProjectDM]
    @Published var selection: UUID = UUID()
    @Published var showingCreateProject: Bool = false
    @Published var order: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.stringId, order: SortOrder.forward)
    ]
    
    init(_dataSource: ProjectRepository) {
        dataSource = _dataSource
        projects = dataSource.getAll()
    }
    
    private var sortedProjects: [ProjectDM] {
        return projects.sorted(using: order)
    }
    
    func getProjects() {
        projects =  dataSource.getAll()
    }
    
     var selectedProject: ProjectDM  {
         return sortedProjects.first(where: { $0.id == selection }) ??  ProjectDM(id: UUID(), name: "")
    }
    
    
}
