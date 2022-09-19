//
//  CreateIssueView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/8/22.
//

import SwiftUI
import Domain

struct CreateIssueView: View {
    @Binding var issueCreationShowing: Bool
    @State var project: ProjectDM
    var vm: ProjectsLandingPageViewModel
    
    @State  var title: String = ""
    @State  var type: String = ""
    @State  var info: String = ""
    
    var body: some View {
        VStack {
            GroupBox {
                Form {
                    Text("Title")
                    TextField("", text: $title)
                    Text("Type")
                    TextField("", text: $type)
                    Text("Description")
                    TextField("", text: $info)
                    HStack {
                        Button("Save") {
                            
                            issueCreationShowing.toggle()
                        }
                        Button("Cancel") {
                            issueCreationShowing.toggle()
                        }
                    }
                    .padding(10)
                }
                .padding()
            }
            .padding(10)
        }
        .frame(width:300)
    }
}