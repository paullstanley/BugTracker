//
//  CreateProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class CreateProjectViewModel: ObservableObject {
    private let repository: ProjectRepository
    let addProjectUseCase: IAddProjectUseCase
    
    @Published var project: ProjectDM = ProjectDM(id: UUID(), name: "", creationDate: String(describing: Date()))
    
    init(storageProvider: StorageProvider) {
        repository = ProjectRepository(storageProvider: storageProvider)
        addProjectUseCase = AddProjectUseCase(projectRepository: self.repository)
    }
    
    func execute() {
        guard let newProject: ProjectDM =  addProjectUseCase.execute(project) else { return }
        project = newProject
    }
}
