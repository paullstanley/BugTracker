//
//  ProjectsTableView.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct ProjectsTableView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    
    var body: some View {
        VStack {
            DynamicStack {
                Spacer()
                Text("Current Projects")
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
            Table(projectsLandingPageVM.sortedProjects.sorted(using: projectsLandingPageVM.projectOrder), selection: $projectsLandingPageVM.projectSelection, sortOrder: $projectsLandingPageVM.projectOrder) {
                TableColumn("Id", value: \.id)
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.creationDate)
                TableColumn("Info", value: \.info)
                TableColumn("Last Modified", value: \.lastModified)
                TableColumn("Stage", value: \.stage)
                TableColumn("Deadline", value: \.deadline)
            }
        }
        .scaleEffect()
    }
}


