//
//  IEditProjectUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IEditProjectUseCase {
    func execute(_ project: ProjectDM)-> ProjectDM?
}
