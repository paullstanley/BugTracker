//
//  iOSAddIssueView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin
import UseCases
import Domain

struct iOSAddIssueView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @ObservedObject var addIssueVM: AddIssueViewModel
   
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        self.addIssueVM = AddIssueViewModel(storageProvider: storageProvider)
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    var body: some View {
                Form {
                    Text("Title")
                    TextField("", text: $addIssueVM.issue.title)
                    Text("Type")
                    TextField("", text: $addIssueVM.issue.type)
                    Text("Description")
                    TextField("", text: $addIssueVM.issue.info)
                }
                .onSubmit {
                    addIssueVM.issue.project = projectsLandingPageVM.selectedProject
                    addIssueVM.issue.projectIdentifier = projectsLandingPageVM.selectedProject.stringId
                    addIssueVM.issue.id = projectsLandingPageVM.selectedProject.stringId
                    
                    addIssueVM.execute()
                    projectsLandingPageVM.projectIssues.append(addIssueVM.issue)
                    self.presentationMode.wrappedValue.dismiss()
                }
    }
}
