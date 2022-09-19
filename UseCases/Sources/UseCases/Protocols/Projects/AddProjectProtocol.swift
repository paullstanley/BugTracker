//
//  File.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Foundation
import Domain

public protocol AddProjectProtocol {
    func execute(_ project: ProjectDM)-> ProjectDM?
}
