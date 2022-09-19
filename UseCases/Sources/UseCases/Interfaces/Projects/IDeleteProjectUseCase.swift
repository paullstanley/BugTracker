//
//  IDeleteProjectUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IDeleteProjectUseCase {
    func execute(_ project: ProjectDM)-> Bool
}
