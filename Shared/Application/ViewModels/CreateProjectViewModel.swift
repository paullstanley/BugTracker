//
//  CreateProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class CreateProjectViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    
    @Published var project: ProjectDM = ProjectDM(id: "", name: "", creationDate: String(describing: Date()))
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
    }
    
    func execute() {
        guard let newProject = dataSource.create(project) else { return }
        project = newProject
    }
}
