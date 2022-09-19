//
//  IAddProject.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IAddProject {
    func execute(_ project: ProjectDM)-> ProjectDM?
}
