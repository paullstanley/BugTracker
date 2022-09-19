//
//  FirstProjectNamingAssistant.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/10/22.
//

import SwiftUI
import CoreDataPlugin
import Domain

struct FirstProjectNamingAssistant: View {
    let landingPageVM: LandingPageViewModel
    let storageProvider: StorageProvider
    
    @ObservedObject var vm: CreateProjectViewModel
    @State var nextView = false
    
    init(landingPageVM: LandingPageViewModel, storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        self.landingPageVM = landingPageVM
        vm = CreateProjectViewModel(storageProvider: storageProvider)
    }
    
    var body: some View {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                if nextView == true {
                    FirstProjectDetailsAssistant(landingPageVM: landingPageVM, storageProvider: storageProvider, vm: vm)
                } else {
                    DynamicStack {
                        Spacer()
                        DynamicStack {
                            #if os(iOS)
                            Text("Let's name your project")
                            .padding(.horizontal)
                            .font(.title)
                            .fontWeight(.light)
                            #else
                            Text("Let's name your project")
                                .font(.system(size: 32))
                                .fontWeight(.ultraLight)
                                .fixedSize()
                                .padding()
                            #endif
                                HStack {
                                    TextField("", text: $vm.project.name)
                                        .labelsHidden()
                                        .background(.thickMaterial)
                                        .border(Color.accentColor, width: 2)
                                        .cornerRadius(2)
                                        .padding(.leading, 10)
                                        .padding(.horizontal)
                                        
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
                                .background(.orange.gradient)
                                .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 0.5, y: 1.5)
                                .border(Color.accentColor.gradient, width: 2)
                                .cornerRadius(2)
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
                        Spacer()
                    }
                }
            }
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .navigationTitle("")
            .scaleEffect()
    }
}

//struct FirstProjectNamingAssistant_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstProjectNamingAssistant()
//    }
//}
