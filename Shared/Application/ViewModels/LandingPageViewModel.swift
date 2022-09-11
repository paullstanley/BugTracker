//
//  LandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation

class LandingPageViewModel: ObservableObject {
    private let dataSource: ProjectRepository
    
    @Published var selection: String = ""
    @Published var selectedMenu: MenuItem?
    @Published var isShowing: Bool = false
    
    init() {
        dataSource = ProjectRepository(_storageProvider: CoreDataStack())
    }
}
