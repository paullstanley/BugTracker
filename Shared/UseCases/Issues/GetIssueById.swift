//
//  GetIssueById.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetIssueById {
    func execute()-> IssueDM?
}

struct GetIssueById: IGetIssueById {
    func execute() -> IssueDM? {
        return nil
    }
}
