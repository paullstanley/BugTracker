//
//  ProjectsLandingPageView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//
import SwiftUI
import CoreDataPlugin

struct iOSProjectsLandingPageView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsLandingPageVM:  ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        projectsLandingPageVM = ProjectsLandingPageViewModel(storageProvider: self.storageProvider)
    }
    
    var body: some View {
        VStack {
            VStack {
                iOSProjectItemView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                HStack {
                    iOSDeleteProjectView(projectsLandingPageVM: projectsLandingPageVM, deleteProjectVM: DeleteProjectViewModel(storageProvider: storageProvider))
                    Button {
                        projectsLandingPageVM.showingCreateProject.toggle()
                    } label: {
                        Label("Create", systemImage: "plus")
                    }
                }
                .sheet(isPresented: $projectsLandingPageVM.showingCreateIssue, content: {
                    AddIssueView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                        .onDisappear(perform: {
                            projectsLandingPageVM.getProjects()
                        })
                })
                .sheet(isPresented: $projectsLandingPageVM.showingCreateProject, content: {
                    iOSAddProjectView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                        .onDisappear(perform: {
                            projectsLandingPageVM.getProjects()
                        })
                })
            }
            DynamicStack {
                iOSProjectsTableView(projectsLandingPageVM: projectsLandingPageVM)
                
                iOSIssueTableView(projectsLandingPageVM: projectsLandingPageVM)
            }
            
            Spacer()
        }
    }
}


