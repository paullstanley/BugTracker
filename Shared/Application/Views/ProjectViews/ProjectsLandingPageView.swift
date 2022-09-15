//
//  ProjectsLandingPageView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import StorageProvider

struct ProjectsLandingPageView: View {
    let storageProvider: StorageProvider
    @State var vm: ProjectsLandingPageViewModel
    
    init(_storageProvider: StorageProvider) {
        
        storageProvider = _storageProvider
        vm = ProjectsLandingPageViewModel(repository: ProjectRepository(storageProvider: storageProvider))
    }
    
    var body: some View {
        VStack {
            #if os(iOS)
            DynamicStack {
                ProjectItemView(vm: vm)
                HStack {
                    DeleteProjectView(project: vm.selectedProject, storageProvider: storageProvider)
                    Button {
                        vm.showingCreateProject.toggle()
                    } label: {
                        Label("Create", systemImage: "plus")
                    }
                    .padding()
                }
            }
            .border(Color.accentColor, width: 3)
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
            IssueTableView(vm: vm)
                .border(Color.accentColor, width: 3)
                .cornerRadius(3)
                .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
            #else
            HStack {
                VStack {
                    ProjectItemView(vm: vm)
                    HStack {
                        DeleteProjectView(project: vm.selectedProject, storageProvider: storageProvider)
                        Button {
                            vm.showingCreateProject.toggle()
                        } label: {
                            Label("Create", systemImage: "plus")
                        }
                        
                        .padding()
                    }
                }
                .fixedSize()
                .border(Color.accentColor, width: 3)
                .cornerRadius(3)
                .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                IssueTableView(vm: vm)
                    .border(Color.accentColor, width: 3)
                    .cornerRadius(3)
                    .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
            }
            .scaledToFit()
            .padding()
            .sheet(isPresented: $vm.showingCreateProject, content: {
                CreateProjectView(storageProvider: storageProvider)
                    .onDisappear(perform: {
                        vm.getProjects()
                    })
            })
            #endif
            ProjectsTableView(vm: vm)
                .padding()
        }
        //.scaledToFit()
    }
}

struct ProjectsLandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsLandingPageView(_storageProvider: StorageProvider())
    }
}



