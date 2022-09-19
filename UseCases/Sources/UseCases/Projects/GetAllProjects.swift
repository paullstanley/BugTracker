//
//  GetAllProjects.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Domain

struct GetAllProjects: IGetAllProjects {
    let projectRepository: IProjectRepository
    
    func execute()-> [ProjectDM] {
        return projectRepository.getAll()
    }   
}
