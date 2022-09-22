//
//  ProjectsTableView.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct ProjectsTableView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var selection: UUID?
    
    var sortedProjects: [ProjectDM]  {
        projectsLandingPageVM.projects
            .sorted(using: projectsLandingPageVM.projectOrder)
    }
    
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
            Table(projectsLandingPageVM.sortedProjects, selection: $selection, sortOrder: $projectsLandingPageVM.projectOrder) {
                TableColumn("Id", value: \.stringId)
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.creationDate)
                TableColumn("Info", value: \.info)
                TableColumn("Last Modified", value: \.lastModified)
                TableColumn("Stage", value: \.stage)
                TableColumn("Deadline", value: \.deadline)
            }
        }
        .scaleEffect()
        .onChange(of: selection, perform: { _ in
            projectsLandingPageVM.updateProjectSelection(selection)
        })
    }
}


