//
//  IViewIssuesByProject.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

protocol IViewIssuesByProject {
    func execute()-> [IssueDM]
}
