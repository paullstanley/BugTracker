//
//  FirstLaunchView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI

struct FirstProjectView: View {
    @State var moving = false
    @State var nextView = false
    @State var skip = false
    
    var body: some View {
            VStack {
                if nextView == true {
                    FirstProjectNamingAssistant()
                } else if skip == true {
                    LandingPageView()
                } else {
                    ZStack {
                        Color.accentColor
                        VStack {
                            Spacer()
                            Group {
                                Text("Hello!")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                Text("It looks like this is the first time the app has launched.")
                                    .fontWeight(.light)
                                Text("Get started by creating a ")
                                    .fontWeight(.ultraLight) +
                                Text("new project.")
                                    .fontWeight(.light)
                                    .foregroundColor(Color.yellow)
                            }
                            .fixedSize()
                            .font(.system(.body, design: .rounded))
                            .padding(.horizontal)
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title)
                                    .offset(x: moving ? -10 : -20)
                                    .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                                    .animation(.spring(response: 1.0, dampingFraction: 0.0, blendDuration: 0.0).repeatForever(autoreverses: false), value: moving)
                                    .onAppear {
                                        DispatchQueue.main.async {
                                            moving = true
                                        }
                                    }
                                Button {
                                    withAnimation {
                                        nextView = true
                                    }
                                } label: {
                                    Image(systemName: "folder.badge.plus")
                                        .font(.system(size: 36))
                                        .padding()
                                        .background(Color.orange.gradient)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                                }
                            }
                            .fixedSize()
                            .buttonStyle(.plain)
                            .padding(.horizontal)
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        skip = true
                                    }
                                } label: {
                                    Text("Skip")
                                        .bold()
                                        .underline()
                                    + Text(" >")
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                        }
                    }
                    
                }
            }
        .toolbar(content: {
            Text(" ")
        })
        .navigationTitle("")
    }
}
