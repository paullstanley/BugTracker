//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain

protocol GetAllProjectsProtocol {
    func execute()-> [ProjectDM]
}