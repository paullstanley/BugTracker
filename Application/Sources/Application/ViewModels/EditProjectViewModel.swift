//
//  EditProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import CoreDataPlugin
import Domain

class EditProjectViewModel: ObservableObject {
    private let repository: ProjectRepository
    
    init() {
        repository = ProjectRepository(storageProvider: StorageProvider())
    }
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        repository.edit(project)
    }
}
