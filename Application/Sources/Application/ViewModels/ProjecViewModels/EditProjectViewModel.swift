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
    private let editProjectUseCase = EditProjectUseCase(projectRepository: ProjectRepository(storageProvider: StorageProvider()))
    @Published var project: ProjectDM?
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        self.project = editProjectUseCase.execute(project)
        return self.project ?? project
    }
}
