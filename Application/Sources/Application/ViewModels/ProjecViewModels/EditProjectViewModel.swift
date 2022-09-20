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
    private let repository: IProjectRepository
    
    init() {
        repository = ProjectRepository(storageProvider: StorageProvider())
    }
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        repository.edit(project)
    }
}
