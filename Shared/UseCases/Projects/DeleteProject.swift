//
//  DeleteProject.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IDeleteProject {
    func execute()-> Bool
}

struct DeleteProject: IDeleteProject {
    func execute() -> Bool {
        return true
    }
}
