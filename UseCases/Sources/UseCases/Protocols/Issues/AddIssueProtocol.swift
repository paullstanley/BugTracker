//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import Foundation
import Domain

public protocol AddIssueProtocol {
    func execute(_ issue: IssueDM)-> IssueDM?
}
