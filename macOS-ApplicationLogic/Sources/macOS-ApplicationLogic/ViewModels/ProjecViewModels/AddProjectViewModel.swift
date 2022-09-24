//
//  CreateProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import Domain
import UseCases

class AddProjectViewModel: ObservableObject {
    private let addProjectUseCase: IAddProjectUseCase
    
    @Published var project: ProjectDM = ProjectDM()
    
    init(repository: IProjectRepository) {
        addProjectUseCase = AddProjectUseCase(repository: repository)
    }
    
    func execute() {
        if project.id.isEmpty {
            project.id = UUID().uuidString
        }
        guard let newProject: ProjectDM =  addProjectUseCase.execute(project) else { return }
        project = newProject
    }
}
