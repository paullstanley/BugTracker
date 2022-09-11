//
//  ProjectDetailsView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI

struct ProjectDetailsView: View {
    @State var issueCreationShowing: Bool = false
    var project: ProjectDM
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                Group {
                    Text("Name:")
                    Text("Creation Date:")
                }
                .bold()
                
                Text(project.name)
                Text(project.creationDate)
            }
            .sheet(isPresented: $issueCreationShowing, content: {
                    CreateIssueView(issueCreationShowing: $issueCreationShowing, project: project)
                    
                })
            HStack {
                Button("Create new issue") {
                    issueCreationShowing.toggle()
                }
            }
        }
    }
}

