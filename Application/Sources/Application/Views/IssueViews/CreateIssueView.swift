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

struct CreateIssueView: View {
    @ObservedObject var createIssueVM: CreateIssueViewModel
    @State var landingPageVM: ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider, landingPageVM: ProjectsLandingPageViewModel) {
        self.createIssueVM = CreateIssueViewModel(storageProvider: storageProvider)
        self.landingPageVM = landingPageVM
    }
    
    @State  var title: String = ""
    @State  var type: String = ""
    @State  var info: String = ""
    
    var body: some View {
        DynamicStack {
            GroupBox {
                Form {
                    Text("Title")
                    TextField("", text: $title)
                    Text("Type")
                    TextField("", text: $type)
                    Text("Description")
                    TextField("", text: $info)
                    HStack {
                        Button("Save") {
                            createIssueVM.issue = IssueDM(id: landingPageVM.selectedProject.stringId, title: title, type: type, creationDate: Date().formatted(), info: info, lastModified: Date().formatted(), project: landingPageVM.selectedProject, projectIdentifier: landingPageVM.selectedProject.stringId)
                            
                            createIssueVM.execute()
                            landingPageVM.showingCreateIssue.toggle()
                        }
                        Button("Cancel") {
                            landingPageVM.showingCreateIssue.toggle()
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

class CreateIssueViewModel: ObservableObject {
    private let repository: IssueRepository
    
    @Published var issue: IssueDM = IssueDM(id: UUID().uuidString)
    
    init(storageProvider: StorageProvider) {
        repository = IssueRepository(storageProvider: storageProvider)
    }
    
    func execute() {
        guard let newIssue: IssueDM = AddIssueUseCase(issueRepository: repository).execute(issue) else { return }
        issue = newIssue
    }
}
