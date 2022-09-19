//
//  EditProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain

struct EditProjectView: View {
    let project: ProjectDM
    let vm = EditProjectViewModel()
    
    @StateObject var parentVM: ProjectsLandingPageViewModel
    
    @State var name = ""
    @State var info = ""
    @State var deadline = ""
    @State var stage = ""
    
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
                            let newProject = ProjectDM(id: project.id, name: name, info: info, stage: stage, deadline: deadline)
                            _ = vm.execute(newProject)
                                parentVM.getProjects()
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


