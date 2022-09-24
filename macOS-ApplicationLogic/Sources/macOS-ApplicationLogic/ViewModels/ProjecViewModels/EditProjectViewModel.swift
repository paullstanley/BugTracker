//
//  EditProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class EditProjectViewModel: ObservableObject {
    private let editProjectUseCase: EditProjectUseCase
    
    @Published var project: ProjectDM = ProjectDM()
                                                       
    init(repository: IProjectRepository) {
        self.editProjectUseCase = EditProjectUseCase(repository: repository)
    }
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        guard let editedProject = editProjectUseCase.execute(project) else { return project }
        self.project = editedProject
        return editedProject
    }
}
