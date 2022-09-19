//
//  IssueTableView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI
import CoreDataPlugin

struct IssueTableView: View {
    let storageProvider: StorageProvider
    @ObservedObject var vm: ProjectsLandingPageViewModel
    
    var body: some View {
        VStack {
            DynamicStack {
                Spacer()
                    Text(vm.selectedProject.name)
                        .foregroundColor(.orange)
                    Text(" Issues")
                    .fixedSize()
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
                TableColumn("Type", value: \.type)
            }
            .padding()
            Button {
                vm.showingCreateIssue.toggle()
            } label: {
                Label("New Issue", systemImage: "plus")
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .popover(isPresented: $vm.showingCreateIssue, content: {
                CreateIssueView(storageProvider: storageProvider, landingPageVM: vm)
            })
        }
        
    }
}
