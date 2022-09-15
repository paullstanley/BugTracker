//
//  LandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import StorageProvider

class LandingPageViewModel: ObservableObject {
   let repository: ProjectRepository
    
    @Published var selection: String = ""
    @Published var selectedMenu: MenuItem?
    @Published var isShowing: Bool = false
    
    init(storageProvider: StorageProvider) {
        repository = ProjectRepository(storageProvider: storageProvider)
    }
}
