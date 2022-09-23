//
//  iOSItemListView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin
import Domain

struct iOSIssueListView: View {
    @StateObject var issueListVM = IssueListViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    let project: ProjectDM
    
    @State private var toBeDeleted: IndexSet? = nil
    @State private var showingDeleteAlert: Bool = false

    
    var body: some View {
            List {
                ForEach(project.issues, id: \.id) {
                    NavigationLink($0.title, value: $0)
                        .alert(isPresented: $showingDeleteAlert) {
                            
                            Alert(title: Text("Are you sure?"), message: Text("Yes?"), primaryButton: .destructive(Text("Delete")) {
                                guard let indexSet = toBeDeleted else { return }
                                
                                let issueToDelete = indexSet.map { issueListVM.issues[$0] }
                                issueListVM.issues.remove(atOffsets: toBeDeleted!)
                                    _ = issueToDelete.compactMap { issue in
                                        
    //                                    if(DeleteIssueUseCase(issueRepository: IssueRepository(storageProvider: storageProvider)).execute(issue)) {
    //                                        DispatchQueue.main.async {
    //                                            project.issues.removeAll { $0 == issue}
    //                                        }
    //                                    }
                                    }
                                self.toBeDeleted = nil
                            }, secondaryButton: .cancel() {
                                self.toBeDeleted = nil
                            }
                            )
                        }
                }
                .onDelete(perform: self.deleteRow)
                .navigationTitle("Issues")
               
                NavigationLink(destination: {
                    iOSAddIssueView(project: project)
                        .onDisappear(perform: {
                            issueListVM.getIssues()
                        })
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .navigationDestination(for: ProjectDM.self) { issue in
                iOSProjectDetailView(project: project)
            }
        
        
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet
        self.showingDeleteAlert = true
    }
}
