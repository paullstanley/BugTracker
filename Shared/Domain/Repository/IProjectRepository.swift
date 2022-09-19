//
//  IProjectRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

protocol IProjectRepository {
    func getAll()-> [ProjectDM]
    func getByName(_ name: String)-> ProjectDM?
    
    func create(_ project: ProjectDM)-> ProjectDM?
    func edit(_ project: ProjectDM)-> ProjectDM
    func delete(_ project: ProjectDM)-> Bool
}
