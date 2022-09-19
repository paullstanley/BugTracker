//
//  IIssueRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation
import Domain

public protocol IIssueRepository {
    func getAll()-> [IssueDM]
    func getByName(_ title: String)-> IssueDM?
    
    func create(_ issue: IssueDM)-> IssueDM?
    func edit(_ issue: IssueDM)-> IssueDM
    func delete(_ issue: IssueDM)-> Bool
}
