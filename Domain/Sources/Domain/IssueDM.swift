//
//  IssueDM.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

public struct IssueDM {
    
    public init(id: String = "", title: String = "", type: String = "", creationDate: String = "", info: String = "", lastModified: String = "", project: ProjectDM? = nil, projectIdentifier: String = "") {
        self.id = id
        self.title = title
        self.type = type
        self.creationDate = creationDate
        self.info = info
        self.lastModified = lastModified
        self.project = project
        self.projectIdentifier = projectIdentifier
        
    }
    public var id: String
    public var title: String
    public var type: String
    public var creationDate: String
    public var info: String
    public var lastModified: String
    public var project: ProjectDM?
    public var projectIdentifier: String
}

extension IssueDM: Identifiable { }

extension IssueDM: Hashable {
    public static func == (lhs: IssueDM, rhs: IssueDM) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension IssueDM {
    public static let placeHolder: IssueDM = IssueDM()
}
