//
//  iOSProjectListView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//
import Foundation
import SwiftUI
import CoreDataPlugin
import Domain
import UseCases

struct iOSProjectListView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsLandingPageVM:  ProjectsLandingPageViewModel
    
    @State private var toBeDeleted: IndexSet? = nil
    @State private var showingDeleteAlert: Bool = false
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        projectsLandingPageVM = ProjectsLandingPageViewModel(storageProvider: self.storageProvider)
        projectsLandingPageVM.getProjects()
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                NavigationLink(destination: {
                    iOSAddProjectView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding()
            List {
                ForEach(projectsLandingPageVM.projects, id: \.id) {
                    NavigationLink($0.name, value: $0)
                        .alert(isPresented: $showingDeleteAlert) {
                            
                            Alert(title: Text("Are you sure?"), message: Text("Yes?"), primaryButton: .destructive(Text("Delete")) {
                                
                                let projectToDelete = toBeDeleted!.map { self.projectsLandingPageVM.projects[$0] }
                                
                                self.projectsLandingPageVM.projects.remove(atOffsets: toBeDeleted!)
                                
                                _ = projectToDelete.compactMap { project in
                                    if(DeleteProjectUseCase(projectRepository: ProjectRepository(storageProvider: storageProvider)).execute(project)) {
                                        DispatchQueue.main.async {
                                            self.projectsLandingPageVM.projects.removeAll { $0 == project}
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
            }
            .navigationTitle("Projects")
            .navigationDestination(for: ProjectDM.self) { project in
                iOSProjectDetailView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
            }
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet
        self.showingDeleteAlert = true
    }
}


