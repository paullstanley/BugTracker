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
    @State var addIssueVM: AddIssueViewModel
    @State var isShowing: Bool = true
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    
   
    
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
                    addIssueVM.issue.id = projectsLandingPageVM.selectedProject.id
                    
                    addIssueVM.execute()
                    projectsLandingPageVM.getProjects()
                   
                }
    }
}
