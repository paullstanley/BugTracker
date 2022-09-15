//
//  ProjectItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct ProjectItemView: View {
    @ObservedObject var vm: ProjectsLandingPageViewModel
    @State var showingEditView: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Project Details")
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
                        EditProjectView(project: vm.selectedProject, parentVM: vm)
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
                        Text("Name:")
                            .bold()
                        Text(vm.selectedProject.name)
                    }
                    HStack {
                        Text("Creation Date:")
                            .bold()
                        Text("\(vm.selectedProject.creationDate)")
                    }
                    HStack {
                        Text("Stage:")
                            .bold()
                        Text("\(vm.selectedProject.stage ?? "")")
                    }
                    HStack {
                        Text("Information:")
                            .bold()
                        Text("\(vm.selectedProject.info ?? "")")
                    }
                }
                .padding(.leading, 10)
            }
            .font(.system(.body, design: .rounded))
        }
        .scaleEffect()
    }
}

//struct ProjectItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectItemView(vm: ProjectsLandingPageViewModel(_dataSource: ProjectRepository(_storageProvider: CoreDataStack())))
//    }
//}
//
//
