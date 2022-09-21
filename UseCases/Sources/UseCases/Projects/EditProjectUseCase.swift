//
//  EditProjectUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct EditProjectUseCase: IEditProjectUseCase {
    private let projectRepository: IProjectRepository
    
    public init(projectRepository: IProjectRepository) {
        self.projectRepository = projectRepository
    }
    
    public func execute(_ project: ProjectDM) -> ProjectDM? {
        projectRepository.edit(project)
    }
}
