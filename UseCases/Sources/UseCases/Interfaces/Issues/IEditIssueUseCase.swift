//
//  IEditIssueUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

public protocol IEditIssueUseCase {
    func execute(_ issue: IssueDM) -> IssueDM?
}
