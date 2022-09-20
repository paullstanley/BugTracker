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
    @ObservedObject var projectsLandingPageView: ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        self.addIssueVM = AddIssueViewModel(storageProvider: storageProvider)
        self.projectsLandingPageView = projectsLandingPageVM
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
                            addIssueVM.issue.project = projectsLandingPageView.selectedProject
                            addIssueVM.issue.projectIdentifier = projectsLandingPageView.selectedProject.stringId
                            addIssueVM.issue.id = projectsLandingPageView.selectedProject.stringId
                            
                            addIssueVM.execute()
                            projectsLandingPageView.showingCreateIssue.toggle()
                        }
                        Button("Cancel") {
                            projectsLandingPageView.showingCreateIssue.toggle()
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

