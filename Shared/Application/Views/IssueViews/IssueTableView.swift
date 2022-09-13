//
//  IssueTableView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI

struct IssueTableView: View {
    @ObservedObject var vm: ProjectsLandingPageViewModel
    @State var isCreateIssueShowing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    Text(vm.selectedProject.name)
                        .foregroundColor(.orange)
                    Text(" Issues")
                Spacer()
            }
            .font(.title)
            .foregroundColor(.white)
            .bold()
            .padding()
            .background(Color.accentColor.gradient)
            .cornerRadius(3)
            .scaleEffect()
            Table(vm.selectedProject.issues ?? []) {
                TableColumn("Title", value: \.title)
                TableColumn("Type", value: \.type!)
            }
            .padding()
            Button {
                isCreateIssueShowing.toggle()
            } label: {
                Label("New Issue", systemImage: "plus")
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .popover(isPresented: $isCreateIssueShowing, content: {
                CreateIssueView(issueCreationShowing: $isCreateIssueShowing, project: vm.selectedProject)
            })
        }
        
    }
}
