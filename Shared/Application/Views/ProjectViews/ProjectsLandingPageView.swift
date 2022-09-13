//
//  ProjectsLandingPageView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct ProjectsLandingPageView: View {
    @StateObject var vm = ProjectsLandingPageViewModel(_dataSource: ProjectRepository(_storageProvider: CoreDataStack()))
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ProjectItemView(vm: vm)
                    HStack {
                        DeleteProjectView(parentVM: vm)
                        Button {
                            vm.showingCreateProject.toggle()
                        } label: {
                            Label("Create", systemImage: "plus")
                                .fixedSize()
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
            }
            .padding()
            
            .sheet(isPresented: $vm.showingCreateProject, content: {
                CreateProjectView(isShowing: $vm.showingCreateProject)
                    .onDisappear(perform: {
                        vm.getProjects()
                    })
            })
            ProjectsTableView(vm: vm)
                .padding()
        }
        .scaleEffect()
    }
}

struct ProjectsLandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsLandingPageView()
    }
}



