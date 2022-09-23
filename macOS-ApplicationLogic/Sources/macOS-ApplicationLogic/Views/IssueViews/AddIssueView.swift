//
//  CreateIssueView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain
import CoreDataPlugin
import UseCases

struct AddIssueView: View {
    @State var addIssueVM: AddIssueViewModel
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        self.addIssueVM = AddIssueViewModel(storageProvider: storageProvider)
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    var body: some View {
        DynamicStack {
            GroupBox {
                Form {
                    Text("Title")
                    TextField("", text: $addIssueVM.issue.title)
                    Text("Type")
                    TextField("", text: $addIssueVM.issue.type)
                    Text("Description")
                    TextField("", text: $addIssueVM.issue.info)
                    HStack {
                        Button("Save") {
                            addIssueVM.issue.project = projectsLandingPageVM.selectedProject
                    
                            addIssueVM.execute()
                            projectsLandingPageVM.getProjects()
                            projectsLandingPageVM.showingCreateIssue.toggle()
                        }
                        Button("Cancel") {
                            projectsLandingPageVM.showingCreateIssue.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .cornerRadius(5)
                }
                .padding(5)
                .cornerRadius(5)
            }
        }
        .frame(width:300)
    }
}

