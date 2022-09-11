//
//  GetUserById.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IGetUserById {
    func execute()-> UserDM?
}

struct GetUserById: IGetUserById {
    func execute() -> UserDM? {
        return nil
    }
}
