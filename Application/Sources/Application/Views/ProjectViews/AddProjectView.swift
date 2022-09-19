//
//  AddProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import CoreDataPlugin

struct AddProjectView: View {
    @State var landingPageVM: ProjectsLandingPageViewModel
    @ObservedObject var vm: CreateProjectViewModel
    
    init(storageProvider: StorageProvider, landingPageVM: ProjectsLandingPageViewModel) {
        vm = CreateProjectViewModel(storageProvider: storageProvider)
        self.landingPageVM = landingPageVM
    }
    
    var body: some View {
        DynamicStack {
                GroupBox {
                    Form {
                        Text("Project name")
                        TextField("", text: $vm.project.name)
                        Text("Project stage")
                        TextField("", text: $vm.project.stage)
                        Text("Project deadline")
                        TextField("", text: $vm.project.deadline)
                        Text("Project info")
                        TextField("", text: $vm.project.info)
                        HStack {
                            Button {
                                vm.execute()
                                landingPageVM.showingCreateProject.toggle()
                            } label: {
                                Label("Create", systemImage: "plus")
                            }
                            .cornerRadius(5)
                            Button {
                                landingPageVM.showingCreateProject.toggle()
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


