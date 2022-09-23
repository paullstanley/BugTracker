//
//  DeleteIssueView.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import SwiftUI

struct DeleteIssueView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var deleteIssueVM: DeleteIssueViewModel
    
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
