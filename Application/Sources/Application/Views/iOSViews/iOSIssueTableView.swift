//
//  iOSIssueTableView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import Domain

struct iOSIssueTableView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var selection: String?
    
    var sortedIssues: [IssueDM] {
        projectsLandingPageVM.selectedProject.issues?.sorted(using: projectsLandingPageVM.issueOrder) ?? []
    }
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text(projectsLandingPageVM.selectedProject.name)
                        .foregroundColor(.orange)
                    Text(" Issues")
                    Spacer()
                }
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .background(Color.accentColor.gradient)
                
                Table(sortedIssues, selection: $selection, sortOrder: $projectsLandingPageVM.issueOrder) {
                    TableColumn("Id", value: \.id)
                    TableColumn("Creation Date", value: \.creationDate)
                    TableColumn("Title", value: \.title)
                    TableColumn("Type", value: \.type)
                    TableColumn("Info", value: \.info)
                }
            }
        .onChange(of: selection, perform: { _ in
            projectsLandingPageVM.updateIssueSelection(selection)
        })
    }
}
