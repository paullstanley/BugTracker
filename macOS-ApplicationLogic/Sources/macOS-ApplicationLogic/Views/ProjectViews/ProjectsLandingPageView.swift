//
//  ProjectsLandingPageView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct ProjectsLandingPageView: View {
    @StateObject var projectsLandingPageVM = ProjectsLandingPageViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ProjectDetailView(projectsLandingPageVM: projectsLandingPageVM)
                    HStack {
                        DeleteProjectView(projectsLandingPageVM: projectsLandingPageVM)
                        Button {
                            projectsLandingPageVM.showingCreateProject.toggle()
                        } label: {
                            Label("Create", systemImage: "plus")
                        }
                        .padding()
                    }
                }
                .border(Color.accentColor, width: 3)
                .cornerRadius(3)
                .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                VStack {
                    IssueItemView(projectsLandingPageVM: projectsLandingPageVM)
                    HStack {
                        DeleteIssueView(projectsLandingPageVM: projectsLandingPageVM)
                        Button {
                            projectsLandingPageVM.showingCreateIssue.toggle()
                        } label: {
                            Label("Create", systemImage: "plus")
                        }
                        .padding()
                    }
                }
                .border(Color.accentColor, width: 3)
                .cornerRadius(3)
                .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
            }
            .scaleEffect()
            .padding()
            .sheet(isPresented: $projectsLandingPageVM.showingCreateIssue, content: {
                AddIssueView(issue: IssueDM(project: projectsLandingPageVM.selectedProject))
            })
            .sheet(isPresented: $projectsLandingPageVM.showingCreateProject, content: {
                AddProjectView()
            })
            HStack {
                ProjectsTableView(projectsLandingPageVM: projectsLandingPageVM)
                IssueTableView(projectsLandingPageVM: projectsLandingPageVM)
            }
            .padding()
        }
    }
}
