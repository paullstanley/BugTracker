//
//  DeleteProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class DeleteProjectViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    @Published var isDeleted: Bool = false
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
    }
    
    func execute(_ project: ProjectDM) {
        isDeleted = dataSource.delete(project)
    }
}
