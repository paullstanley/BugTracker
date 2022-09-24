//
//  EditProjectUseCase.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

public struct EditProjectUseCase: IEditProjectUseCase {
    private let repository: IProjectRepository
    
    public init(repository: IProjectRepository) {
        self.repository = repository
    }
    
    public func execute(_ project: ProjectDM) -> ProjectDM? {
        repository.edit(project)
    }
}
