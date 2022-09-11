//
//  IssueTableView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI

struct IssueTableView: View {
    var issues: [IssueDM]
    var body: some View {
        VStack {
            Text("Issues")
                .bold()
                .fixedSize()
            Table(issues) {
                TableColumn("Title", value: \.title)
                TableColumn("Type", value: \.type!)
            }
        }
        .scaleEffect()
        .padding()
    }
}
