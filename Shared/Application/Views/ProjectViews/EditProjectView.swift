//
//  EditProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI

struct EditProjectView: View {
    @ObservedObject var vm = EditProjectViewModel()
    @Binding var project: ProjectDM
    
    var body: some View {
        Button("Edit Project") {
            project = vm.execute(project)
        }
    }
}


