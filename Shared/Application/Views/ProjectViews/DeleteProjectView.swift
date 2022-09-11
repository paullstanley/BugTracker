//
//  DeleteProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct DeleteProjectView: View {
    @ObservedObject var vm = DeleteProjectViewModel()
    var project: ProjectDM?
    
    var body: some View {
        Button("Delete Entity") {
            if let projectToDelete = project {
                if vm.execute(projectToDelete) == true {
                    print("Successfully deleted \(project)")
                } else {
                    print("There was an issue deleting the project - \(project)")
                }
            }
        }
    }
}

