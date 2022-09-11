//
//  EditUser.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IEditUser {
    func execute()-> UserDM?
}

struct EditUser: IEditUser {
    func execute() -> UserDM? {
        return nil
    }
}
