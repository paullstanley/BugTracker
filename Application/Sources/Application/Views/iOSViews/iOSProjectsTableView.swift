//
//  iOSProjectsTableView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import Domain

struct iOSProjectsTableView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var selection: UUID?
    
    var sortedProjects: [ProjectDM]  {
        projectsLandingPageVM.projects
            .sorted(using: projectsLandingPageVM.projectOrder)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Projects")
                Spacer()
            }
            .font(.title2)
            .foregroundColor(.white)
            .bold()
            .background(Color.accentColor.gradient)
            
            Table(sortedProjects, selection: $selection, sortOrder: $projectsLandingPageVM.projectOrder) {
                TableColumn("Id", value: \.stringId)
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.creationDate)
                TableColumn("Info", value: \.info)
                TableColumn("Last Modified", value: \.lastModified)
                TableColumn("Stage", value: \.stage)
                TableColumn("Deadline", value: \.deadline)
            }
            
        }
        .onChange(of: selection, perform: { _ in
            projectsLandingPageVM.updateProjectSelection(selection)
        })
    }
}

