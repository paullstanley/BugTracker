//
//  ProjectItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct ProjectItemView: View {
    @State var project: ProjectMO
    
    var body: some View {
        HStack {
            Text(project.name)
            Spacer()
            Text("\(project.id)")
        }
    }
}


