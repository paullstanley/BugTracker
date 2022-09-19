//
//  ProjectDM.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

public struct ProjectDM {
    
    public init(id: UUID, name: String = "", creationDate: String = "", info: String = "", lastModified: String = "", stage: String = "", deadline: String = "", issues: [IssueDM]? = []) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.info = info
        self.lastModified = lastModified
        self.stage = stage
        self.deadline = deadline
        self.issues = issues
    }
    
    public let id: UUID
    public var name: String
    public let creationDate: String
    public var info: String
    public let lastModified: String
    public var stage: String
    public var deadline: String
    public var issues: [IssueDM]?
}


extension ProjectDM {
    public var stringId: String {
        String(describing: id)
    }
}

extension ProjectDM {
    public var issueCount: String {
        String(describing: issues?.count ?? 0)
    }
}

extension ProjectDM: Identifiable { }