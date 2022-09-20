//
//  AddProjectUseCase.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public class AddProjectUseCase: IAddProjectUseCase {
    public let projectRepository: IProjectRepository
    
    public init(projectRepository: IProjectRepository) {
        self.projectRepository = projectRepository
    }
    
    public func execute(_ project: ProjectDM) -> ProjectDM? {
        projectRepository.create(project)
    }
}