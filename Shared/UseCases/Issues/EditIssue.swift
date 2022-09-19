//
//  EditIssue.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

protocol IEditIssue {
    func execute()-> IssueDM?
}

struct EditIssue: IEditIssue {
    func execute() -> IssueDM? {
        return nil
    }
}
