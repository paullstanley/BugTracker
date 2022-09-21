//
//  iOSAddProjectView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin

struct iOSAddProjectView: View {
    @State var projectsLandingPageVM: ProjectsLandingPageViewModel
    @ObservedObject var addProjectViewModel: AddProjectViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        addProjectViewModel = AddProjectViewModel(storageProvider: storageProvider)
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    var body: some View {
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
}
