//
//  IssueTableView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI
import Domain

struct IssueTableView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var selection: String?
    
    var sortedIssues: [IssueDM] {
        projectsLandingPageVM.selectedProject.issues.sorted(using: projectsLandingPageVM.issueOrder)
    }
    
    var body: some View {
        VStack {
            DynamicStack {
                Spacer()
                Text(projectsLandingPageVM.selectedProject.name)
                    .foregroundColor(.orange)
                Text(" Issues")
                    .fixedSize()
                Spacer()
            }
            .font(.title)
            .foregroundColor(.white)
            .bold()
            .padding()
            .background(Color.accentColor.gradient)
            .cornerRadius(3)
            .scaleEffect()
            
            Table(sortedIssues, selection: $selection, sortOrder: $projectsLandingPageVM.issueOrder) {
                TableColumn("Id", value: \.id)
                TableColumn("Creation Date", value: \.creationDate)
                TableColumn("Title", value: \.title)
                TableColumn("Type", value: \.type)
                TableColumn("Info", value: \.info)
            }
        }
        .scaleEffect()
        .onChange(of: selection, perform: { _ in
            projectsLandingPageVM.updateIssueSelection(selection)
        })
    }
}
