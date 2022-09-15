//
//  DeleteProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import StorageProvider
import CoreData

class DeleteProjectViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    @Published var isDeleted: Bool = false
    
    init(_storageProvider: StorageProvider) {
        dataSource = ProjectRepository(_storageProvider: _storageProvider)
    }
    
    func execute(_ project: ProjectDM) {
        isDeleted = dataSource.delete(project)
    }
}
