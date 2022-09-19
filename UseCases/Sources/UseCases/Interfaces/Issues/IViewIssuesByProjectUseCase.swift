//
//  IViewIssuesByProjectUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

protocol IViewIssuesByProjectUseCase {
    func execute()-> [IssueDM]
}
