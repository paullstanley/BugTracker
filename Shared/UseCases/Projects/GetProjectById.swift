//
//  GetProjectById.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetProjectById {
    func execute()-> ProjectDM?
}

struct GetProjectById: IGetProjectById {
    func execute()-> ProjectDM? {
        return nil
    }
}
