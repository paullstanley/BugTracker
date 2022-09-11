//
//  DeleteIssue.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IDeleteIssue {
    func execute()-> Bool
}

struct DeleteIssue: IDeleteIssue {
    func execute() -> Bool {
        return true
    }
}
