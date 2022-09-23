//
//  ViewAllProjectsUseCase.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct ViewAllProjectsUseCase: IViewAllProjectsUseCase {
    private let repository: IProjectRepository
    
    public init(repository: IProjectRepository) {
        self.repository = repository
    }
    
    @discardableResult
    public func execute()-> [ProjectDM] {
        return repository.getAll()
    }   
}
