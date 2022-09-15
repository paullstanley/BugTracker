//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct DeleteProjectView: View {
    @ObservedObject var vm: DeleteProjectViewModel
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
        .cornerRadius(5)
    }
}

//struct DeleteProjectView_Preview: PreviewProvider {
//    static var previews: some View {
//        DeleteProjectView(parentVM: ProjectsLandingPageViewModel(_dataSource: ProjectRepository(_storageProvider: CoreDataStack())))
//    }
//}
