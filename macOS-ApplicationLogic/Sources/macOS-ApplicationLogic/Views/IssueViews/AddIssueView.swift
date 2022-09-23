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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var addIssueVM = AddIssueViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    
    @State var issue: IssueDM
    
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
                            addIssueVM.issue.project = issue.project
                            addIssueVM.execute()
                            presentationMode.wrappedValue.dismiss()
                        }
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
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

