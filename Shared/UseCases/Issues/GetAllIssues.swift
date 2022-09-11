//
//  GetAllIssues.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetAllIssues {
    func execute()-> [IssueDM]
}

struct GetAllIssues: IGetAllIssues {
    func execute()-> [IssueDM] {
        return []
    }
}
