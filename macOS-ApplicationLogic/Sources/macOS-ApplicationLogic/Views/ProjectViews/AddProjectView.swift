//
//  AddProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import CoreDataPlugin

struct AddProjectView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var addProjectVM = AddProjectViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    var body: some View {
        DynamicStack {
                GroupBox {
                    Form {
                        Text("Project name")
                        TextField("", text: $addProjectVM.project.name)
                        Text("Project stage")
                        TextField("", text: $addProjectVM.project.stage)
                        Text("Project deadline")
                        TextField("", text: $addProjectVM.project.deadline)
                        Text("Project info")
                        TextField("", text: $addProjectVM.project.info)
                        HStack {
                            Button {
                                addProjectVM.execute()
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Label("Create", systemImage: "plus")
                            }
                            .cornerRadius(5)
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
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


