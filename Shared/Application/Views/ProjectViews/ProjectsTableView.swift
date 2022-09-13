//
//  ProjectsTableView.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import Foundation

struct ProjectsTableView: View {
    @ObservedObject var vm: ProjectsLandingPageViewModel
    @State var selection: UUID?
    
    var sortedProjects: [ProjectDM]  {
        vm.projects
            .sorted(using: vm.order)
    }
    
    var body: some View {
        VStack {
            Table(sortedProjects, selection: $selection, sortOrder: $vm.order) {
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.stringId)
                //TableColumn("Stage", value: \.stage!)
                //TableColumn("Issues Count", value: \.issueCount)
            }
        }
        .scaleEffect()
        .onChange(of: selection, perform: { _ in
            vm.selection = selection ?? UUID()
        })
    }
}


