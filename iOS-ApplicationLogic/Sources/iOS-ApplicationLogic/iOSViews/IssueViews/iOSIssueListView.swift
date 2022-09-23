//
//  iOSItemListView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin
import UseCases
import Domain

struct iOSIssueListView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsIssuesVM: ProjectsIssuesViewModel
    @ObservedObject var projectsLandingPageVM:  ProjectsLandingPageViewModel
    
    @State private var toBeDeleted: IndexSet? = nil
    @State private var showingDeleteAlert: Bool = false
    
    init(storageProvider: StorageProvider, projectsLandingPageVM:  ProjectsLandingPageViewModel) {
        self.storageProvider = storageProvider
        self.projectsLandingPageVM = projectsLandingPageVM
        self.projectsIssuesVM = ProjectsIssuesViewModel(storageProvider: self.storageProvider)
    }
    
    var body: some View {
        List {
            ForEach(projectsIssuesVM.execute(projectsLandingPageVM.selectedProject), id: \.id) {
                NavigationLink($0.title, value: $0)
                    .alert(isPresented: $showingDeleteAlert) {
                        
                        Alert(title: Text("Are you sure?"), message: Text("Yes?"), primaryButton: .destructive(Text("Delete")) {
                            guard let indexSet = toBeDeleted else { return }
                            
                            let issueToDelete = indexSet.map { self.projectsLandingPageVM.projectIssues[$0] }
                                self.projectsLandingPageVM.projectIssues.remove(atOffsets: toBeDeleted!)
                                _ = issueToDelete.compactMap { issue in
                                    
                                    if(DeleteIssueUseCase(issueRepository: IssueRepository(storageProvider: storageProvider)).execute(issue)) {
                                        DispatchQueue.main.async {
                                            self.projectsLandingPageVM.projectIssues.removeAll { $0 == issue}
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
            .onDelete(perform: self.deleteRow)
            .navigationTitle("Issues")
           
            NavigationLink(destination: {
                iOSAddIssueView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                    .onDisappear(perform: {
                        projectsLandingPageVM.getProjects()
                    })
            }, label: {
                Image(systemName: "plus")
            })
        }
        .navigationDestination(for: ProjectDM.self) { issue in
            iOSProjectDetailView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet
        self.showingDeleteAlert = true
    }
}
