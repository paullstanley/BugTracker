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
    
    @Published var project: ProjectDM = ProjectDM(id: UUID(), name: "", creationDate: String(describing: Date()))
    
    init(storageProvider: StorageProvider) {
        repository = ProjectRepository(storageProvider: storageProvider)
    }
    
    func execute() {
        let newProject =  AddProject(projectRepository: repository).execute(project)
        project = newProject!
    }
}
