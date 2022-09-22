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
    @ObservedObject var projectsLandingPageVM:  ProjectsLandingPageViewModel
    
    init(storageProvider: StorageProvider, projectsLandingPageVM:  ProjectsLandingPageViewModel) {
        self.storageProvider = storageProvider
        self.projectsLandingPageVM = projectsLandingPageVM
    }
    
    var body: some View {
        List {
            ForEach(projectsLandingPageVM.selectedProject.issues, id: \.id) {
                NavigationLink($0.title, value: $0)
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
        let issueToDelete = indexSet.map { self.projectsLandingPageVM.projectIssues[$0] }
        
        _ = issueToDelete.compactMap { issue in
            if(DeleteIssueUseCase(issueRepository: IssueRepository(storageProvider: storageProvider)).execute(issue)) {
                DispatchQueue.main.async {
                    self.projectsLandingPageVM.projectIssues.removeAll { $0 == issue }
                    projectsLandingPageVM.getProjects()
                }
            }
        }
        self.projectsLandingPageVM.projects.remove(atOffsets: indexSet)
    }
}
