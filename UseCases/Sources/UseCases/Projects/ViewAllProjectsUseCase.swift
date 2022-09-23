//
//  ViewAllProjectsUseCase.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct ViewAllProjectsUseCase: IViewAllProjectsUseCase {
    private let projectRepository: IProjectRepository
    
    public init(repository: IProjectRepository) {
        projectRepository = repository
    }
    
    public func execute()-> [ProjectDM] {
        return projectRepository.getAll()
    }   
}
