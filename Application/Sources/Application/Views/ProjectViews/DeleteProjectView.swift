//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct DeleteProjectView: View {
    @ObservedObject var landingPageVM: ProjectsLandingPageViewModel
    @State var vm: DeleteProjectViewModel
    
    var body: some View {
        Button {
            vm.execute(landingPageVM.selectedProject)
            landingPageVM.getProjects()
        } label: {
            Label("Delete", systemImage: "trash.circle")
        }
        .cornerRadius(5)
    }
}
