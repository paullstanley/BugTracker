//
//  iOSProjectItemView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import Domain
import CoreDataPlugin

struct iOSProjectDetailView: View {
    @StateObject var projectDetailViewModel = ProjectDetailViewModel(repository: ProjectRepository(storageProvider: StorageProvider.shared))
    let project: ProjectDM
    @State var showingEditView: Bool = false
    @State var showingShareView: Bool = false
    
    public var body: some View {
                HStack {
                    Spacer()
                    Text("Project Details")
                        .fixedSize()
                    Button {
                        showingShareView.toggle()
                    } label: {
                        Label("", systemImage: "square.and.arrow.up")
                            .labelsHidden()
                            .fixedSize()
                            .foregroundColor(.orange)
                    }
                    .popover(isPresented: $showingShareView, content: {
                        //SharedProjectDetailView(projectsLandingPageVM: projectsLandingPageVM)
                    })
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
                        iOSEditProjectView(project: project)
                            .onDisappear(perform: {
                                projectDetailViewModel.getProject(project)
                            })
                    })
                }
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .background(Color.accentColor.gradient)
                .cornerRadius(3)
                
                Group {
                    HStack {
                        Text("Name:")
                            .bold()
                        Text(project.name)
                    }
                    HStack {
                        Text("Creation Date:")
                            .bold()
                        Text("\(project.creationDate)")
                    }
                    HStack {
                        Text("Stage:")
                            .bold()
                        Text("\(project.stage)")
                    }
                    HStack {
                        Text("Information:")
                            .bold()
                        Text("\(project.info)")
                    }
                }
                Spacer()
        iOSIssueListView(project: project)
    }
}
