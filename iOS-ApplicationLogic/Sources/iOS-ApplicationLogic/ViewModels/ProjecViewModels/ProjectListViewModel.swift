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
    
    @Published var projects: [ProjectDM] = []
    
    init(repository: IProjectRepository) {
        viewAllProjectsUseCase = ViewAllProjectsUseCase(repository: repository)
        getProjects()
    }
    
    func getProjects() {
        DispatchQueue.main.async {
            self.projects = self.viewAllProjectsUseCase.execute()
        }
        
    }
    
}
