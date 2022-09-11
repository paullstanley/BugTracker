//
//  FirstProjectDetailsAssistant.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI

struct FirstProjectDetailsAssistant: View {
    @State var details: String = ""
    @State var deadline: String = ""
    @State var nextView = false
    @State var previousView = false
    @State var selectedMenu: MenuItem?
    
    var body: some View {
            VStack {
                if nextView == true {
                        LandingPageView()
                        .background()
                } else if previousView == true {
                    FirstProjectNamingAssistant()
                } else {
                    Group {
                        Text("Let's add a few more details")
                            .font(.system(size: 32))
                            .fontWeight(.ultraLight)
                            .fixedSize()
                            .padding(.horizontal)
                        Text("Don't worry, you can edit this information later")
                            .fontWeight(.light)
                            .fixedSize()
                    }
                    .scaleEffect()
                    
                    Form {
                        VStack {
                            Text("Details")
                                .fixedSize()
                                .bold()
                            
                            TextField("", text: $details)
                                .labelsHidden()
                                .background(.thickMaterial)
                                .frame(width:150)
                                .border(Color.accentColor, width: 2)
                                .cornerRadius(2)
                                .padding(.bottom)
                            
                            Text("Expected date of completion")
                                .fixedSize()
                                .bold()
                            
                            TextField("", text: $deadline)
                                .labelsHidden()
                                .background(.thickMaterial)
                                .frame(width:150)
                                .border(Color.accentColor, width: 2)
                                .cornerRadius(2)
                            Button {
                                nextView = true
                            } label: {
                                Image(systemName: "arrow.forward.square")
                                    .bold()
                                    .font(.system(size: 14))
                                    .padding(2)
                                    .background(Color.accentColor.gradient)
                                    .cornerRadius(5)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding()
                        .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 0.5, y: 1.5)
                        .border(Color.accentColor.gradient, width: 2)
                        .cornerRadius(2)
                    }
                    .padding(5)
                    .background(.orange.gradient)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.7), radius: 4.0, x: 2.0, y: 4.0)
                    
                    HStack {
                        Button {
                            previousView = true
                        } label: {
                            Text(".")
                                .foregroundColor(Color.gray)
                        }
                        .buttonStyle(.plain)
                        Text(".")
                        Button {
                            nextView = true
                        } label: {
                            Text(".")
                                .foregroundColor(Color.gray)
                        }
                        .buttonStyle(.plain)
                    }
                    .fixedSize()
                    .bold()
                    .font(.system(size: 32))
                }
            }
            .font(.system(.body, design: .rounded))
            .labelsHidden()
        .navigationTitle("")
        .scaleEffect()
    }
}

struct FirstProjectDetailsAssistant_Previews: PreviewProvider {
    static var previews: some View {
        FirstProjectDetailsAssistant()
    }
}
