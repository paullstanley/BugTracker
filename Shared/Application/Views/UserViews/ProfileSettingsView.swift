//
//  ProfileSettingsView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI

struct ProfileSettingsView: View {
    var body: some View {
        VStack(alignment: .center) {
            GroupBox {
                Image(systemName: "person.circle")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                    .padding(.top)
                Form {
                    Section(header: Text("User Info").font(.title).foregroundColor(.gray).padding(.top)) {
                        Text("Name, Phone, Email")
                        Text("Passwords & Security")
                        Text("Time Zone")
                    }
                    
                    Section(header: Text("Owned Projects").font(.title).foregroundColor(.gray).padding(.top)) {
                            Text("Project 1")
                            Text("Project 2")
                            Text("Project 3")
                            Text("Project 4")
                            Text("Project 5")
                    }
                }
                .fixedSize()
                .padding()
            }
            .padding(10)
        }
        .padding()
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}
