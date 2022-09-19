//
//  IssueItemView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import SwiftUI
import CoreDataPlugin

struct IssueItemView: View {
    @ObservedObject var issue: IssueMO
    
    var body: some View {
        
            Text("\(issue.type)")
     
    }
}
