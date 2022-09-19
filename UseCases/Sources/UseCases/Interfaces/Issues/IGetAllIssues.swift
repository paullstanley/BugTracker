//
//  IGetAllIssues.swift
//  
//
//  Created by Paull Stanley on 9/18/22.
//

import Domain

protocol IGetAllIssues {
    func execute()-> [IssueDM]
}
