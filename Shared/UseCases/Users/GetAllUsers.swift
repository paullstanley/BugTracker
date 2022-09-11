//
//  GetAllUsers.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetAllUsers {
    func execute()-> [UserDM]
}

struct GetAllUsers: IGetAllUsers {
    func execute() -> [UserDM] {
        return []
    }
}
