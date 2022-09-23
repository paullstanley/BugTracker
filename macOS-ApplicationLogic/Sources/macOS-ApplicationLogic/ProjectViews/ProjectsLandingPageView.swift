//
//  ProjectsLandingPageView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import CoreDataPlugin

struct ProjectsLandingPageView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsLandingPageVM:  ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        projectsLandingPageVM = ProjectsLandingPageViewModel(storageProvider: self.storageProvider)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ProjectDetailView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                    HStack {
                        DeleteProjectView(projectsLandingPageVM: projectsLandingPageVM, deleteProjectVM: DeleteProjectViewModel(storageProvider: storageProvider))
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
                    IssueItemView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                    HStack {
                        DeleteIssueView(projectsLandingPageVM: projectsLandingPageVM, deleteIssueVM: DeleteIssueViewModel(storageProvider: storageProvider))
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
                AddIssueView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
            })
            .sheet(isPresented: $projectsLandingPageVM.showingCreateProject, content: {
                AddProjectView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
            })
            HStack {
                ProjectsTableView(projectsLandingPageVM: projectsLandingPageVM)
                IssueTableView(projectsLandingPageVM: projectsLandingPageVM)
            }
            .padding()
        }
    }
}