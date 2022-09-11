//
//  GetAllIssuesForProject.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetAllIssuesForProject {
    func execute()-> [IssueDM]
}

struct GetAllIssuesForProject: IGetAllIssuesForProject {
    func execute()-> [IssueDM] {
        return []
    }
}
