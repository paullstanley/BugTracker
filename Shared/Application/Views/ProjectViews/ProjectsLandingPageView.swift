//
//  ProjectsLandingPageView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct ProjectsLandingPageView: View {
    @ObservedObject var vm = ProjectsLandingPageViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ProjectDetailsView(project: vm.selectedProject)
                
                IssueTableView(issues: vm.selectedProject.issues ?? [])
            }
            .sheet(isPresented: $vm.showingCreateProject, content: {
                CreateProjectView()
            })
            Button("Create new project") {
                vm.showingCreateProject.toggle()
            }
            .fixedSize()
            ProjectsTableView()
        }
        .scaleEffect()
    }
}


