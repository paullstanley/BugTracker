//
//  AddProjectUseCase.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public struct AddProjectUseCase: IAddProjectUseCase {
    private let repository: IProjectRepository
    
    public init(repository: IProjectRepository) {
        self.repository = repository
    }
    
    @discardableResult
    public func execute(_ project: ProjectDM) -> ProjectDM? {
        repository.create(project)
    }
}
