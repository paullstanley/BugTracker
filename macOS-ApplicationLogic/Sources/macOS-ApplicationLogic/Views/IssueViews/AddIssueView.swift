//
//  CreateIssueView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct AddIssueView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var addIssueVM = AddIssueViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    @State var project: ProjectDM
    
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
                        Button {
                            addIssueVM.issue.project = project
                            addIssueVM.execute()
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("Create", systemImage: "plus")
                        }
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    .cornerRadius(5)
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

