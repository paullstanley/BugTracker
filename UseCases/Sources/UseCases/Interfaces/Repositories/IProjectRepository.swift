//
//  IProjectRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

public protocol IProjectRepository {
    func getAll()-> [ProjectDM]
    func getByName(_ name: String)-> ProjectDM?
    func getAllIssues(for project: ProjectDM)-> [IssueDM]
    func create(_ project: ProjectDM)-> ProjectDM?
    func edit(_ project: ProjectDM)-> ProjectDM
    func delete(_ project: ProjectDM)-> Bool
}
