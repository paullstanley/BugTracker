//
//  SwiftUIView.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import SwiftUI
import CoreDataPlugin

public struct MainView: View {
    let storageProvider: StorageProvider = StorageProvider.shared
    var isFirstLaunch: Bool = false
    
    public init() { }
    
    public var body: some View {
        if isFirstLaunch {
            FirstProjectView()
        } else {
            LandingPageView()
            
        }
    }
}
