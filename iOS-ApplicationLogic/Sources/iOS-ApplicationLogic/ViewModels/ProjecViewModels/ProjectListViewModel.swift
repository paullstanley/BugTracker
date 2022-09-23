//
//  ProjectListViewModel.swift
//  
//
//  Created by Paull Stanley on 9/23/22.
//

import Foundation
import Domain
import UseCases

class ProjectListViewModel: ObservableObject {
    private let viewAllProjectsUseCase: IViewAllProjectsUseCase
    private let deleteProjectUseCase: IDeleteProjectUseCase
    
    @Published var projects: [ProjectDM] = []
    
    init(repository: IProjectRepository) {
        viewAllProjectsUseCase = ViewAllProjectsUseCase(repository: repository)
        deleteProjectUseCase = DeleteProjectUseCase(repository: repository)
        getProjects()
    }
    
    func delete(_ project: ProjectDM) {
        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self {
                _ = strongSelf.deleteProjectUseCase.execute(project)
            }
        }
    }
    
    func getProjects() {
        DispatchQueue.main.async {
            self.projects = self.viewAllProjectsUseCase.execute()
        }
        
    }
    
}
