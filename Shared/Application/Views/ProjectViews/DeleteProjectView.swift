//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct DeleteProjectView: View {
    @ObservedObject var vm = DeleteProjectViewModel()
    let parentVM: ProjectsLandingPageViewModel
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                vm.execute(parentVM.selectedProject)
                parentVM.getProjects()
            }
        } label: {
            Label("Delete", systemImage: "trash.circle")
        }
        .background(Color.red)
        .cornerRadius(5)
    }
}

