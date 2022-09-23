//
//  iOSProjectListView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//
import Foundation
import SwiftUI
import Domain
import CoreDataPlugin

public struct iOSProjectListView: View {
    @StateObject var projectListVM = ProjectListViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    
    @State private var toBeDeleted: IndexSet? = nil
    @State private var showingDeleteAlert: Bool = false
    
    public var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                NavigationLink(destination: {
                    iOSAddProjectView()
                        .onDisappear {
                            projectListVM.getProjects()
                        }
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding()
            List {
                ForEach(projectListVM.projects, id: \.id) {
                    NavigationLink($0.name, value: $0)
                        .alert(isPresented: $showingDeleteAlert) {
                            
                            Alert(title: Text("Are you sure?"), message: Text("Yes?"), primaryButton: .destructive(Text("Delete")) {
                                
                                let projectToDelete = toBeDeleted!.map { projectListVM.projects[$0] }
                                
                                projectListVM.projects.remove(atOffsets: toBeDeleted!)
                                
                                _ = projectToDelete.compactMap { project in
//                                    if(DeleteProjectUseCase(projectRepository: ProjectRepository(storageProvider: storageProvider)).execute(project)) {
//                                        DispatchQueue.main.async {
//                                            self.projects.removeAll { $0 == project}
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
            }
            .navigationTitle("Projects")
            .navigationDestination(for: ProjectDM.self) { project in
                iOSProjectDetailView(project: project)
                  
            }
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet
        self.showingDeleteAlert = true
    }
}


