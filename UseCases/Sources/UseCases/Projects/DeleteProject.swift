//
//  DeleteProject.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

public struct DeleteProject: DeleteProjectProtocol {
    public let projectRepository: IProjectRepository
    
    public init(projectRepository: IProjectRepository) {
        self.projectRepository = projectRepository
    }
    
    public func execute(_ project: ProjectDM) -> Bool {
        projectRepository.delete(project)
    }
}
