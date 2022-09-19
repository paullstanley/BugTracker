//
//  iOSWelcomePageVIew.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/13/22.
//

import SwiftUI

struct iOSWelcomePageVIew: View {
    private var symbols = ["doc.fill.badge.plus", "doc", "chart.xyaxis.line", "scale.3d", "house"]
    private var labels = ["New", "Open", "Feed", "Projects", "Home"]
    private var colors: [AnyGradient] = [Color.green.gradient, Color.yellow.gradient, Color.red.gradient, Color.orange.gradient, Color.brown.gradient]
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.heavy)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(0..<symbols.count, id: \.self) { i in
                        NavigationLink(destination: //CreateProjectView(storageProvider: StorageProvider()),
                                       Text("hello")  ,label: {
                            VStack {
                                Image(systemName: symbols[i])
                                    .resizable()
                                    .aspectRatio(3/2.5, contentMode: .fit )
                                Text(labels[i])
                                    .fixedSize()
                            }
                            .padding()
                            .background(colors[i])
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                        })
                    }
                }
                .padding()
            }
        }
        .foregroundColor(.white)
    }
}

struct iOSWelcomePageVIew_Previews: PreviewProvider {
    static var previews: some View {
        iOSWelcomePageVIew()
    }
}
