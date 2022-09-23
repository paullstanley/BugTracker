//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct DeleteProjectView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var deleteProjectVM: DeleteProjectViewModel
    
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
