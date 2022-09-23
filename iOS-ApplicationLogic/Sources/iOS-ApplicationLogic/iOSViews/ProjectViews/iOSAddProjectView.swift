//
//  iOSAddProjectView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin


struct iOSAddProjectView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var addProjectVM = AddProjectViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    var body: some View {
        Form {
            Text("Project name")
            TextField("", text: $addProjectVM.project.name)
            Text("Project stage")
            TextField("", text: $addProjectVM.project.stage)
            Text("Project deadline")
            TextField("", text: $addProjectVM.project.deadline)
            Text("Project info")
            TextField("", text: $addProjectVM.project.info)
                .buttonStyle(.borderedProminent)
        }
        .onSubmit {
            addProjectVM.execute()
           self.presentationMode.wrappedValue.dismiss()
        }
        .padding()
        .cornerRadius(5)
    }
}
