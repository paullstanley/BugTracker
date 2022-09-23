//
//  IViewIssuesByProjectUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IViewIssuesByProjectUseCase {
    func execute(_ project: ProjectDM) -> [IssueDM]
}
