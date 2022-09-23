//
//  iOSDeleteProjectView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import Domain
import CoreDataPlugin


struct DeleteProjectView: View {
    @StateObject var deleteProjectVM = DeleteProjectViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    let project: ProjectDM
    
    var body: some View {
        Button {
            deleteProjectVM.execute(project)
        } label: {
            Label("Delete", systemImage: "trash.circle")
        }
        .cornerRadius(5)
    }
}

