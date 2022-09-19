//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain

protocol GetAllIssuesForProjectProtocol {
    func execute()-> [IssueDM]
}
