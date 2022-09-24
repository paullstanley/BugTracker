//
//  LandingPageViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import Foundation
import Domain
import UseCases

public class LandingPageViewModel: ObservableObject {
    private let viewAllProjectsUseCase: IViewAllProjectsUseCase
    
    @Published var selection: String = ""
    @Published var selectedMenu: MenuItem?
    @Published var isShowing: Bool = false
    
    @Published var projects: [ProjectDM] = []
    
    public init(repository: IProjectRepository) {
        viewAllProjectsUseCase = ViewAllProjectsUseCase(repository: repository)
        getProjects()
    }
    
    func getProjects() {
        projects = viewAllProjectsUseCase.execute()
    }
    
}
