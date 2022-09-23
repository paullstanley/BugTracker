//
//  DeleteIssueView.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import SwiftUI
import CoreDataPlugin

struct DeleteIssueView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @StateObject var deleteIssueVM = DeleteIssueViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    
    var body: some View {
        Button {
            deleteIssueVM.execute(projectsLandingPageVM.selectedIssue)
            projectsLandingPageVM.getProjects()
        } label: {
            Label("Delete", systemImage: "trash.circle")
        }
        .cornerRadius(5)
    }
}
