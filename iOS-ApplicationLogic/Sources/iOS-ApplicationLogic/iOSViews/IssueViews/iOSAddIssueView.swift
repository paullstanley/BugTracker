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
    
    @StateObject var addIssueVM = AddIssueViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    let project: ProjectDM
    
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
                    addIssueVM.issue.project = project
                    addIssueVM.execute()
                    presentationMode.wrappedValue.dismiss()
                   
                }
    }
}
