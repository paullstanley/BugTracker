//
//  iOSAddProjectView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin
import Domain

struct iOSAddProjectView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
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
                .buttonStyle(.borderedProminent)
        }
        .onSubmit {
            addProjectViewModel.execute()
            projectsLandingPageVM.getProjects()
            
            projectsLandingPageVM.showingCreateProject.toggle()
           // self.presentationMode.wrappedValue.dismiss()
        }
        .padding()
        .cornerRadius(5)
    }
}
