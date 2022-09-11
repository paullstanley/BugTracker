//
//  ProjectsTableView.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct ProjectsTableView: View {
    @ObservedObject var vm = ProjectTableViewModel()
    
    var body: some View {
        VStack {
            Table(vm.projects, selection: $vm.selection, sortOrder: $vm.order) {
                TableColumn("Name", value: \.name)
                TableColumn("Creation date", value: \.creationDate)
                TableColumn("Stage", value: \.stage!)
                TableColumn("Issues Count", value: \.issueCount)
            }
        }
        .scaleEffect()
    }
}


