//
//  FirstProjectView.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI
import CoreDataPlugin

public struct FirstProjectView: View {
    let vm: LandingPageViewModel
    let storageProvider: StorageProvider
    
    @State var moving = false
    @State var nextView = false
    @State var skip = false
    
    public init(vm: LandingPageViewModel, storageProvider: StorageProvider, moving: Bool = false, nextView: Bool = false, skip: Bool = false) {
        self.vm = vm
        self.storageProvider = storageProvider
        self.moving = moving
        self.nextView = nextView
        self.skip = skip
    }
    
    public var body: some View {
        VStack {
            if nextView == true {
                FirstProjectNamingAssistant(landingPageVM: vm, storageProvider: storageProvider)
            } else if skip == true {
                LandingPageView(vm: vm, storageProvider: storageProvider)
            } else {
                ZStack {
                    Color.accentColor
                        .ignoresSafeArea()
                        Spacer()
                        VStack {
                            Spacer()
                                #if os(iOS)
                                Text("Hello!")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .shadow(color: Color.black.opacity(0.5), radius: 4.0, x: 3.0, y: 3.0)
                                VStack {
                                    Text("It looks like this is the first time the app has launched.")
                                        
                                    Text("Get started by creating a ") +
                                    Text("new project.")
                                        .foregroundColor(Color.yellow)
                                }
                                .fixedSize()
                                #else
                                Text("Hello!")
                                    .font(.system(size: 36))
                                    .fontWeight(.heavy)
                                    .shadow(color: Color.black.opacity(0.5), radius: 4.0, x: 3.0, y: 3.0)
                               
                                Group {
                                    Text("It looks like this is the first time the app has launched.")
                                    Text("Get started by creating a ") +
                                    Text("new project.")
                                        .foregroundColor(Color.yellow)
                                }
                                .fixedSize()
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                #endif
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 26))
                                    .offset(x: moving ? -10 : -20)
                                    .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                                    .animation(.spring(response: 1.0, dampingFraction: 0.0, blendDuration: 0.0).repeatForever(autoreverses: false), value: moving)
                                    .onAppear {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                moving = true
                                            }
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
                                        .font(.system(size: 16))
                                        .bold()
                                        .underline()
                                    + Text(" >")
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                        }
                        .font(.system(.body, design: .rounded))
                        .scaledToFit()
                    
                }
                .foregroundColor(.white)
            }
        }
        .toolbar(content: {
            Text(" ")
        })
        .navigationTitle("")
    }
}
