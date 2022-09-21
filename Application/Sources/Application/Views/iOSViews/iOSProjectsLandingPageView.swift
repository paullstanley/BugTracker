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
        projectsLandingPageVM = ProjectsLandingPageViewModel(repository: ProjectRepository(storageProvider: self.storageProvider))
    }
    
    var body: some View {
        VStack {
            VStack {
                iOSProjectItemView(projectsLandingPageVM: projectsLandingPageVM)
                HStack {
                    DeleteProjectView(projectsLandingPageVM: projectsLandingPageVM, deleteProjectVM: DeleteProjectViewModel(storageProvider: storageProvider))
                    Button {
                        projectsLandingPageVM.showingCreateProject.toggle()
                    } label: {
                        Label("Create", systemImage: "plus")
                    }
                }
            }
            DynamicStack {
                iOSProjectsTableView(projectsLandingPageVM: projectsLandingPageVM)
                
                iOSIssueTableView(projectsLandingPageVM: projectsLandingPageVM)
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
            
            //            HStack {
            //                iOSProjectsTableView(projectsLandingPageVM: projectsLandingPageVM)
            //                iOSIssueTableView(projectsLandingPageVM: projectsLandingPageVM)
            //            }
            Spacer()
        }
        
    }
}


