//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/23/22.
//

import Foundation
import Domain
import UseCases
import CoreDataPlugin

class ProjectDetailViewModel: ObservableObject {
    private let repository: IProjectRepository
    
    @Published var project: ProjectDM = .placeHolder
    
    init(repository: IProjectRepository) {
        self.repository = repository
    }
    
    func getProject(_ project: ProjectDM) {
        guard let _project = repository.getByName(project.name) else { return }
        self.project = _project
    }
}
