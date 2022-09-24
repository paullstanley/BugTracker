//
//  EditIssueView.swift
//  
//
//  Created by Paull Stanley on 9/20/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct EditIssueView: View {
    @Environment(\.dismiss) var onDissmiss: DismissAction
    @StateObject var editIssueVM =  EditIssueViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    
    let issue: IssueDM
    
    @State var title: String = ""
    @State var type: String = ""
    @State var info: String = ""
    
    var body: some View {
        VStack {
            GroupBox {
                Form {
                    Text("Issue Title")
                    TextField("", text: $title)
                    Text("Issue Type")
                    TextField("", text: $type)
                    Text("Issue Info")
                    TextField("", text: $info)
                    HStack {
                        Button("Save") {
                            let newIssue = IssueDM(id: issue.id, title: title, type: type, creationDate: issue.creationDate, info: info, lastModified: Date().formatted())
                            _ = editIssueVM.execute(newIssue)
                            onDissmiss()
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
