//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import StorageProvider

struct DeleteProjectView: View {
    let project: ProjectDM
    let storageProvider: StorageProvider
    
    @ObservedObject var vm: DeleteProjectViewModel
   // let parentVM: ProjectsLandingPageViewModel
    
    init(project: ProjectDM, storageProvider: StorageProvider) {
        self.project = project
        self.storageProvider = storageProvider
        vm = DeleteProjectViewModel(storageProvider: storageProvider)
    }
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                vm.execute(project)
               // parentVM.getProjects()
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
