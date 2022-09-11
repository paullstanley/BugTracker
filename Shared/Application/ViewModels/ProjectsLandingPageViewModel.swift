//
//  ProjectsLandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class ProjectsLandingPageViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    private let projects: [ProjectDM]
    
    @Published var selection: String? = ""
    @Published var showingCreateProject: Bool = false
    
    var selectedProject: ProjectDM {
        projects.first(where: { $0.id == selection }) ??  ProjectDM(name: "")
    }
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
        projects = dataSource.getAll()
    }
}
