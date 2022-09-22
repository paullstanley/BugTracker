//
//  ProjectDM.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import Foundation

public struct ProjectDM {
    
    public init(id: UUID, name: String = "", creationDate: String = "", info: String = "", lastModified: String = "", stage: String = "", deadline: String = "", issues: [IssueDM]? = nil) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.info = info
        self.lastModified = lastModified
        self.stage = stage
        self.deadline = deadline
        self.issues = issues ?? []
    }
    
    public let id: UUID
    public var name: String
    public let creationDate: String
    public var info: String
    public let lastModified: String
    public var stage: String
    public var deadline: String
    public var issues: [IssueDM] = []
}

extension ProjectDM {
    public mutating func addIssue(_ issue: IssueDM) {
        issues.append(issue)
    }
}


extension ProjectDM {
    public var stringId: String {
        String(describing: id)
    }
}

extension ProjectDM {
    public var issueCount: String {
        String(describing: issues.count)
    }
}

extension ProjectDM: Identifiable { }

extension ProjectDM: Hashable {
    public static func == (lhs: ProjectDM, rhs: ProjectDM) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ProjectDM {
    public static let placeHolder: ProjectDM = ProjectDM(id: UUID())
}
