//
//  CreateProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import StorageProvider

struct CreateProjectView: View {
    let storageProvider: StorageProvider
    @ObservedObject var vm: CreateProjectViewModel
    
    //@Binding var isShowing: Bool
    
    init(_storageProvider: StorageProvider) {
        storageProvider = _storageProvider
        vm = CreateProjectViewModel(_storageProvider: _storageProvider)
    }
    
    var body: some View {
            VStack {
                GroupBox {
                    Form {
                        Text("Project name")
                        TextField("", text: $vm.project.name)
                        Text("Project stage")
                        TextField("", text: $vm.project.stage.withDefault(""))
                        Text("Project deadline")
                        TextField("", text: $vm.project.deadline.withDefault(""))
                        Text("Project info")
                        TextField("", text: $vm.project.info.withDefault(""))
                        HStack {
                            Button {
                                vm.execute()
                                //isShowing.toggle()
                            } label: {
                                Label("Create", systemImage: "plus")
                            }
                            .cornerRadius(5)
                            Button {
                               // isShowing.toggle()
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


