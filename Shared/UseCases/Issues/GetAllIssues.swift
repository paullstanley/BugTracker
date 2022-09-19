//
//  GetAllIssues.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

protocol IGetAllIssues {
    func execute()-> [IssueDM]
}

struct GetAllIssues: IGetAllIssues {
    func execute()-> [IssueDM] {
        return []
    }
}
