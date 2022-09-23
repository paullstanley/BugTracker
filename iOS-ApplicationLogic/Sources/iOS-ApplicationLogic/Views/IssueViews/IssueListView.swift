//
//  iOSItemListView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin
import Domain

struct IssueListView: View {
    @StateObject var issueListVM = IssueListViewModel(repository: IssueRepository(storageProvider: StorageProvider.shared))
    @State var project: ProjectDM
    
    @State private var toBeDeleted: IndexSet? = nil
    @State private var showingDeleteAlert: Bool = false

    
    var body: some View {
            List {
                ForEach(project.issues, id: \.id) {
                    NavigationLink($0.title, value: $0)
                        .alert(isPresented: $showingDeleteAlert) {
                            
                            Alert(title: Text("Are you sure?"), message: Text("Yes?"), primaryButton: .destructive(Text("Delete")) {
                                guard let indexSet = toBeDeleted else { return }
                                issueListVM.issues = project.issues
                                let issueToDelete = indexSet.map { issueListVM.issues[$0] }
                                
                                issueListVM.issues.remove(atOffsets: toBeDeleted!)
                                    _ = issueToDelete.compactMap { issue in
                                        
                                        if(issueListVM.deleteIssue(issue)) {
                                            DispatchQueue.main.async {
                                                issueListVM.issues.removeAll { $0 == issue}
                                                issueListVM.getIssues(for: project)
                                            }
                                        }
                                    }
                                self.toBeDeleted = nil
                            }, secondaryButton: .cancel() {
                                self.toBeDeleted = nil
                            }
                            )
                        }
                }
                .onDelete(perform: deleteRow)
                .navigationTitle("Issues")
               
                NavigationLink(destination: {
                    AddIssueView(project: project)
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .navigationDestination(for: ProjectDM.self) { issue in
                ProjectDetailView(project: self.project)
            }
        
        
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet
        self.showingDeleteAlert = true
    }
}
