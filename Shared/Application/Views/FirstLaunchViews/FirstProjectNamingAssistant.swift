//
//  FirstProjectNamingAssistant.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI

struct FirstProjectNamingAssistant: View {
    @State var name: String = ""
    @State var nextView = false
    
    var body: some View {
            ZStack {
                Color.accentColor
                if nextView == true {
                    FirstProjectDetailsAssistant()
                } else {
                    VStack {
                        Text("Let's start by giving your project a name")
                            .font(.system(size: 32))
                            .fontWeight(.ultraLight)
                            .fixedSize()
                            .padding()
                        Form {
                            HStack {
                                TextField("", text: $name)
                                    .labelsHidden()
                                    .background(.thickMaterial)
                                    .frame(width:150)
                                    .border(Color.accentColor, width: 2)
                                    .cornerRadius(2)
                                    .padding(.leading, 10)
                                    
                                Button {
                                    withAnimation {
                                        nextView = true
                                    }
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
                            Text(".")
                            Button {
                                withAnimation {
                                    nextView = true
                                }
                            } label: {
                                Text(".")
                                    .foregroundColor(Color.gray)
                            }
                            .buttonStyle(.plain)
                            
                            Text(".")
                                .foregroundColor(Color.gray)
                        }
                        .fixedSize()
                        .bold()
                        .font(.system(size: 32))
                    }
                }
            }
            .font(.system(.body, design: .rounded))
            .navigationTitle("")
            .scaleEffect()
    }
}

struct FirstProjectNamingAssistant_Previews: PreviewProvider {
    static var previews: some View {
        FirstProjectNamingAssistant()
    }
}
