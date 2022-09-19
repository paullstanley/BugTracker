//
//  ProjectsTableView.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import Foundation
import Domain

struct ProjectsTableView: View {
    @ObservedObject var vm: ProjectsLandingPageViewModel
    @State var selection: UUID?
    
    var sortedProjects: [ProjectDM]  {
        vm.projects
            .sorted(using: vm.order)
    }
    
    var body: some View {
        DynamicStack {
            Table(sortedProjects, selection: $selection, sortOrder: $vm.order) {
                TableColumn("Id", value: \.stringId)
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.creationDate)
                TableColumn("Info", value: \.info)
                TableColumn("Last Modified", value: \.lastModified)
                TableColumn("Stage", value: \.stage)
                TableColumn("Deadline", value: \.deadline)
            }
        }
        .scaleEffect()
        .onChange(of: selection, perform: { _ in
            vm.selection = selection!
        })
    }
}


