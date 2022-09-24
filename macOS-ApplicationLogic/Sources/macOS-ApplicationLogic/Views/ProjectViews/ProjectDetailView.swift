//
//  ProjectItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import Domain

struct ProjectDetailView: View {
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
                    .sheet(isPresented: $showingEditView, content: {
                        EditProjectView(project: projectsLandingPageVM.selectedProject)
                            .onDisappear {
                                projectsLandingPageVM.getProjects()
                            }
                        
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
