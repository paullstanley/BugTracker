//
//  IAddIssue.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Domain

public protocol IAddIssue {
    func execute(_ issue: IssueDM)-> IssueDM?
}
