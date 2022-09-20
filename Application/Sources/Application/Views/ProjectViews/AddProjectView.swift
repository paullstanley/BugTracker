//
//  AddProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import CoreDataPlugin

struct AddProjectView: View {
    @State var projectsLandingPageVM: ProjectsLandingPageViewModel
    @ObservedObject var addProjectViewModel: AddProjectViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        addProjectViewModel = AddProjectViewModel(storageProvider: storageProvider)
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    var body: some View {
        DynamicStack {
                GroupBox {
                    Form {
                        Text("Project name")
                        TextField("", text: $addProjectViewModel.project.name)
                        Text("Project stage")
                        TextField("", text: $addProjectViewModel.project.stage)
                        Text("Project deadline")
                        TextField("", text: $addProjectViewModel.project.deadline)
                        Text("Project info")
                        TextField("", text: $addProjectViewModel.project.info)
                        HStack {
                            Button {
                                addProjectViewModel.execute()
                                projectsLandingPageVM.showingCreateProject.toggle()
                            } label: {
                                Label("Create", systemImage: "plus")
                            }
                            .cornerRadius(5)
                            Button {
                                projectsLandingPageVM.showingCreateProject.toggle()
                            } label: {
                                Text("Cancel")
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .cornerRadius(5)
                }
                .padding(5)
                .cornerRadius(5)
            }
            .frame(width:300)
            .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
    }
}


