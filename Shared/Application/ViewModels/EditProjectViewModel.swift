//
//  EditProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import StorageProvider

class EditProjectViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    
    init() {
        dataSource = ProjectRepository(_storageProvider:  StorageProvider())
    }
    
    func execute(_ project: ProjectDM)-> ProjectDM {
        dataSource.edit(project)
    }
}
