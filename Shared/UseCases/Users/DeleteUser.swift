//
//  DeleteUser.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IDeleteUser {
    func execute()-> Bool
}

struct DeleteUser: IDeleteUser {
    func execute() -> Bool {
        return true
    }
}
