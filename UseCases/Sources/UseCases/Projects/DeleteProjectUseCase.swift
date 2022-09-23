//
//  DeleteProjectUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct DeleteProjectUseCase: IDeleteProjectUseCase {
    private let repository: IProjectRepository
    
    public init(repository: IProjectRepository) {
        self.repository = repository
    }
    
    @discardableResult
    public func execute(_ project: ProjectDM) -> Bool {
        repository.delete(project)
    }
}
