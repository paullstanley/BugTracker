//
//  EditProject.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

protocol IEditProject {
    func execute()-> ProjectDM?
}

struct EditProject: IEditProject {
    func execute()-> ProjectDM? {
        return nil
    }
}
