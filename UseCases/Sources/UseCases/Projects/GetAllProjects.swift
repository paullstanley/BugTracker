//
//  GetAllProjects.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

struct GetAllProjects: GetAllProjectsProtocol {
    let projectRepository: IProjectRepository
    
    func execute()-> [ProjectDM] {
        return projectRepository.getAll()
    }   
}
