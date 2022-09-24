//
//  DeleteProjectViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import Domain
import UseCases

class DeleteProjectViewModel: ObservableObject {
    private let deleteProjectUseCase: IDeleteProjectUseCase
    @Published var isDeleted: Bool = false
    
    init(repository: IProjectRepository) {
        self.deleteProjectUseCase = DeleteProjectUseCase(repository: repository)
    }
    
    func execute(_ project: ProjectDM) {
        isDeleted = deleteProjectUseCase.execute(project)
    }
}
