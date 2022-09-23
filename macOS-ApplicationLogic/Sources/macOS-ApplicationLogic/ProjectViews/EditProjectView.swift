//
//  EditProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct EditProjectView: View {
    @Environment(\.dismiss) var onDissmiss: DismissAction
    @ObservedObject var editProjectVM: EditProjectViewModel
    
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        editProjectVM = EditProjectViewModel(storageProvider: storageProvider)
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    @State var name: String = ""
    @State var info: String = ""
    @State var deadline: String = ""
    @State var stage: String = ""
    
    var body: some View {
        VStack {
            GroupBox {
                Form {
                    Text("Project name")
                    TextField("", text: $name)
                    Text("Project stage")
                    TextField("", text: $stage)
                    Text("Project deadline")
                    TextField("", text: $deadline)
                    Text("Project info")
                    TextField("", text: $info)
                    HStack {
                        Spacer()
                        Button("Save") {
                            if name.isEmpty { name = projectsLandingPageVM.selectedProject.name }
                            if stage.isEmpty { stage = projectsLandingPageVM.selectedProject.name }
                            if deadline.isEmpty { deadline = projectsLandingPageVM.selectedProject.name }
                            if info.isEmpty { info = projectsLandingPageVM.selectedProject.name }
                            
                            let newProject = ProjectDM(name: name, info: info, stage: stage, deadline: deadline)
                            _ = editProjectVM.execute(newProject)
                            projectsLandingPageVM.getProjects()
                            onDissmiss()
                        }
                        .cornerRadius(5)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .cornerRadius(5)
            }
            .padding(5)
            .cornerRadius(5)
        }
        .fixedSize()
        .frame(width:300)
        .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
    }
}

