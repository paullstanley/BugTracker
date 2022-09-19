//
//  IDeleteProject.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IDeleteProject {
    func execute(_ project: ProjectDM)-> Bool
}
