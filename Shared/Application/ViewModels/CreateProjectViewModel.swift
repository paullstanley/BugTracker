//
//  CreateProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import StorageProvider

class CreateProjectViewModel: ObservableObject {
    let storageProvider: StorageProvider
    private let repository: ProjectRepository
    
    @Published var project: ProjectDM = ProjectDM(id: UUID(), name: "", creationDate: String(describing: Date()))
    
    init(_storageProvider: StorageProvider) {
        storageProvider = _storageProvider
        repository = ProjectRepository(storageProvider: storageProvider)
    }
    
    func execute() {
        guard let newProject = repository.create(project) else { return }
        project = newProject
    }
}
