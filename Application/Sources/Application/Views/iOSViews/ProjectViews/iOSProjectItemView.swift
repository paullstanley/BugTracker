//
//  iOSProjectItemView.swift
//  
//
//  Created by Paull Stanley on 9/21/22.
//

import SwiftUI
import CoreDataPlugin

struct iOSProjectItemView: View {
    let storageProvider: StorageProvider
    @ObservedObject var projectsLandingPageVM: ProjectsLandingPageViewModel
    @State var showingEditView: Bool = false
    @State var showingShareView: Bool = false
    
    init(storageProvider: StorageProvider, projectsLandingPageVM: ProjectsLandingPageViewModel) {
        self.storageProvider = storageProvider
        self.projectsLandingPageVM = projectsLandingPageVM
    }

    public var body: some View {
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
                        iOSEditProjectView(storageProvider: storageProvider, projectsLandingPageVM: projectsLandingPageVM)
                            .onDisappear(perform: {
                                projectsLandingPageVM.getProjects()
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
                        Text(projectsLandingPageVM.selectedProject.name)
                    }
                    HStack {
                        Text("Creation Date:")
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.creationDate)")
                    }
                    HStack {
                        Text("Stage:")
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.stage)")
                    }
                    HStack {
                        Text("Information:")
                            .bold()
                        Text("\(projectsLandingPageVM.selectedProject.info)")
                    }
                }
            }
            .font(.system(.body, design: .rounded))
        }
    }
}
