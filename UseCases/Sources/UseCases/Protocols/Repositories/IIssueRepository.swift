//
//  IIssueRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

protocol IIssueRepository {
    func getAll()-> [IssueDM]
    func getById()-> IssueDM?
    
    func create(_ issue: IssueDM)-> IssueDM?
    func edit(_ issue: IssueDM)-> IssueDM
    func delete(_ issue: IssueDM)-> Bool
}
