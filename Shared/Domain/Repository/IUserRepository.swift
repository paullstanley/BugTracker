//
//  IUserRepository.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

protocol IUserRepository {
    func getAll()-> [UserDM]
    func getById()-> UserDM?
    
    func create(_ user: UserDM)-> UserDM?
    func edit(_ user: UserDM)-> UserDM
    func delete(_ user: UserDM)-> Bool
}
