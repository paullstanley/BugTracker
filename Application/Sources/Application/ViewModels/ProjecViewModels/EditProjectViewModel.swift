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
    
    @Published var project: ProjectDM = ProjectDM(id: UUID())
                                                       
    init(storageProvider: StorageProvider) {
        self.editProjectUseCase = EditProjectUseCase(projectRepository: ProjectRepository(storageProvider: storageProvider))
    }
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        guard let editedProject = editProjectUseCase.execute(project) else { return project }
        self.project = editedProject
        return editedProject
    }
}
