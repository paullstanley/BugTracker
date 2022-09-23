//
//  IIssueRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

public protocol IIssueRepository {
    //func getAll()-> [IssueDM]
    func getAllIssues(for project: ProjectDM)-> [IssueDM]
    func getByName(_ title: String)-> IssueDM?
    
    func create(_ _issue: IssueDM, for _project: ProjectDM) -> IssueDM?
    func edit(_ issue: IssueDM)-> IssueDM
    func delete(_ issue: IssueDM)-> Bool
}
