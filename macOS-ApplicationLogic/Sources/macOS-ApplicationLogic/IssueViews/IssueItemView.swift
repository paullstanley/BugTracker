//
//  IssueItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import CoreDataPlugin

struct IssueItemView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var showingEditView: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Issue Details")
                        .fixedSize()
                    Button {
                        showingEditView.toggle()
                    } label: {
                        Label("", systemImage: "pencil.circle")
                            .labelsHidden()
                            .fixedSize()
                            .foregroundColor(.orange)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showingEditView, content: {
                        EditIssueView(storageProvider: storageProvider, issue: projectsLandingPageVM.selectedIssue)
                            .onDisappear(perform: {
                                projectsLandingPageVM.getProjects()
                            })
                    })
                    Spacer()
                }
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(Color.accentColor.gradient)
                .cornerRadius(3)
                .scaleEffect()
                Group {
                    HStack {
                        Text("Title:")
                            .fixedSize()
                            .bold()
                        Text(projectsLandingPageVM.selectedIssue.title)
                            .fixedSize()
                    }
                    HStack {
                        Text("Type:")
                            .bold()
                        Text("\(projectsLandingPageVM.selectedIssue.type)")
                            .fixedSize()
                    }
                    HStack {
                        Text("Info:")
                            .fixedSize()
                            .bold()
                        Text("\(projectsLandingPageVM.selectedIssue.info)")
                            .fixedSize()
                    }
                }
                .padding(.leading, 10)
            }
            .font(.system(.body, design: .rounded))
        }
        .scaleEffect()
    }
}