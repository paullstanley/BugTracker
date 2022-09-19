//
//  SwiftUIView.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import SwiftUI
import CoreDataPlugin

public struct MainView: View {
    let storageProvider = StorageProvider()
    var isFirstLaunch = false
    
    public init() { }
    
    public var body: some View {
        if isFirstLaunch {
            FirstProjectView(vm: LandingPageViewModel(storageProvider: storageProvider), storageProvider: storageProvider)
        } else {
            LandingPageView(vm: LandingPageViewModel(storageProvider: storageProvider), _storageProvider: storageProvider)
        }
    }
}
