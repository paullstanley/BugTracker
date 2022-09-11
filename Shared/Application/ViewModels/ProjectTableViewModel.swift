//
//  ProjectTableViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class ProjectTableViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    
    @Published var selection: String?
    
    @Published var order: [KeyPathComparator<ProjectDM>] = [
        .init(\ProjectDM.name, order: SortOrder.forward)
    ]
    
    var projects: [ProjectDM] {
        dataSource.getAll()
            .sorted(using: order)
    }
    
    var selectedProject: ProjectDM {
        if let selection = selection {
            if let chosen =  projects.first(where: { $0.id == selection }) {
                return chosen
            }
        } else {
            return ProjectDM(name:"")
        }
        return ProjectDM(name:"")
    }
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
    }
}
