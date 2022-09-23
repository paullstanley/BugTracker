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
    @StateObject var editProjectVM = EditProjectViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    let project: ProjectDM
    
    @State var name: String = ""
    @State var info: String = ""
    @State var deadline: String = ""
    @State var stage: String = ""
    
    var body: some View {
        Form {
            TextField("name", text: $editProjectVM.project.name)
            TextField("stage", text: $editProjectVM.project.stage)
            TextField("deadline", text: $editProjectVM.project.deadline)
            TextField("info", text: $editProjectVM.project.info)
        }
        .onSubmit {
            if name.isEmpty { name = project.name }
            if stage.isEmpty { stage = project.stage }
            if deadline.isEmpty { deadline = project.deadline }
            if info.isEmpty { info = project.info }
            
            let newProject = ProjectDM(id: project.id, name: name, creationDate: project.creationDate, info: info, lastModified: Date().formatted(), stage: stage, deadline: deadline, issues: project.issues)
            editProjectVM.execute(newProject)
            onDissmiss()
        }
    }
}

