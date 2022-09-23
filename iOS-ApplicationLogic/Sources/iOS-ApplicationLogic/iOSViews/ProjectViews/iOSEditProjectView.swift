//
//  iOSEditProjectView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct iOSEditProjectView: View {
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
        Form {
            TextField("name", text: $name)
            TextField("stage", text: $stage)
            TextField("deadline", text: $deadline)
            TextField("info", text: $info)
        }
        .onSubmit {
            if name.isEmpty { name = projectsLandingPageVM.selectedProject.name }
            if stage.isEmpty { stage = projectsLandingPageVM.selectedProject.name }
            if deadline.isEmpty { deadline = projectsLandingPageVM.selectedProject.name }
            if info.isEmpty { info = projectsLandingPageVM.selectedProject.name }
            
            let newProject = ProjectDM(name: name, info: info, stage: stage, deadline: deadline)
            _ = editProjectVM.execute(newProject)
            onDissmiss()
        }
    }
}

