//
//  DeleteProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain
import UseCases

class DeleteProjectViewModel: ObservableObject {
    private let repository: IProjectRepository
    @Published var isDeleted: Bool = false
    
    init(storageProvider: StorageProvider) {
        repository = ProjectRepository(storageProvider: storageProvider)
    }
    
    func execute(_ project: ProjectDM) {
        isDeleted = DeleteProjectUseCase(projectRepository: repository).execute(project)
    }
}