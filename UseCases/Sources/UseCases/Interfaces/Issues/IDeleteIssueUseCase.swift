//
//  IDeleteIssueUseCase.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//
import Domain

public protocol IDeleteIssueUseCase {
    func execute(_ issue: IssueDM)-> Bool
}
