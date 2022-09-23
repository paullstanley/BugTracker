//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import UseCases
import CoreDataPlugin

struct DeleteProjectView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @StateObject var deleteProjectVM = DeleteProjectViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    var body: some View {
        Button {
            deleteProjectVM.execute(projectsLandingPageVM.selectedProject)
            projectsLandingPageVM.getProjects()
        } label: {
            Label("Delete", systemImage: "trash.circle")
        }
        .cornerRadius(5)
    }
}
