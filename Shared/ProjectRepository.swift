//
//  ProjectRepository.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation

class ProjectRepository {
    private let db: StorageProvider
    
    init(db: StorageProvider) {
        self.db = db
    }
    
    public func getProjects()-> [ProjectDM] {
        return []
    }
}
