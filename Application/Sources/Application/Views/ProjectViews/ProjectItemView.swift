//
//  ProjectItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct ProjectItemView: View {
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var showingEditView: Bool = false
    @State var showingShareView: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Project Details")
                        .fixedSize()
#if os(iOS)
                    Button {
                        showingShareView.toggle()
                    } label: {
                        Label("", systemImage: "pencil.circle")
                            .labelsHidden()
                            .fixedSize()
                            .foregroundColor(.orange)
                    }
                    .popover(isPresented: $showingShareView, content: {
                        SharedProjectDetailView(projectsLandingPageVM: projectsLandingPageVM)
                    })
#endif
                    Spacer()
                    
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
                        EditProjectView( projectsLandingPageVM: projectsLandingPageVM)
                            
                    })
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
                        Text("Name:")
                            .fixedSize()
                            .bold()
                        Text(projectsLandingPageVM.selectedProject.name)
                            .fixedSize()
                    }
                    HStack {
                        Text("Creation Date:")
                            .fixedSize()
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.creationDate)")
                            .fixedSize()
                    }
                    HStack {
                        Text("Stage:")
                            .fixedSize()
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.stage)")
                            .fixedSize()
                    }
                    HStack {
                        Text("Information:")
                            .fixedSize()
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.info)")
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
