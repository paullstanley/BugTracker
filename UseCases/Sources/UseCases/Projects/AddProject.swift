//
//  CreateProjectUseCase.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain


public struct AddProject: AddProjectProtocol {
    public let projectRepository: IProjectRepository
    
    public init(projectRepository: IProjectRepository) {
        self.projectRepository = projectRepository
    }
    
    public func execute(_ project: ProjectDM) -> ProjectDM? {
        projectRepository.create(project)
    }
}