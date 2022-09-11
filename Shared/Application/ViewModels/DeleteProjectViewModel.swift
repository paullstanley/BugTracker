//
//  DeleteProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class DeleteProjectViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
    }
    
    func execute(_ project: ProjectDM)-> Bool {
        dataSource.delete(project)
    }
}
