//
//  GetAllProjects.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetAllProjects {
    func execute()-> [ProjectDM]
}

struct GetAllProjects: IGetAllProjects {
    func execute()-> [ProjectDM] {
        //TODO: Methos for fetching projects
        return []
    }
    
    
}
