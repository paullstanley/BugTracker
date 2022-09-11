//
//  IssuesListView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI

struct IssuesListView: View {
    @State var issues: [IssueMO]
    
    var body: some View {
        List(issues) { (issue: IssueMO) in
            IssueItemView(issue: issue)
        }
    }
}
