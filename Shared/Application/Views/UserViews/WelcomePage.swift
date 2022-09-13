//
//  WelcomePage.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/9/22.
//

import SwiftUI

struct WelcomePage: View {
    @State var selection = ""
    @State var isShowing = false
    private var symbols = ["doc.fill.badge.plus", "doc", "chart.xyaxis.line", "scale.3d", "house"]
    private var labels = ["New Project ", "Open Project", "     Feed      ", "Project List", "     Home      "]
    private var colors: [AnyGradient] = [Color.accentColor.gradient, Color.yellow.gradient, Color.teal.gradient, Color.mint.gradient, Color.brown.gradient]
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100), spacing: 10), GridItem(.adaptive(minimum: 100), spacing: 10), GridItem(.adaptive(minimum: 100), spacing: 10), GridItem(.adaptive(minimum: 100), spacing: 10)]
    var body: some View {
        VStack {
            Text(String(describing: Date().formatted()))
                .fontWeight(.ultraLight)
            Text("Welcome")
                .font(.title)
                .fontWeight(.heavy)
            
            LazyVGrid(columns: gridItemLayout, spacing: 75) {
                ForEach(0..<symbols.count) { i in
                    NavigationLink(destination: CreateProjectView(isShowing: $isShowing), label: {
                        VStack {
                            Image(systemName: symbols[i])
                                .font(.system(size: 36))
                                .fixedSize()
                                
                            Text(labels[i])
                                .fixedSize()
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(colors[i])
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.5), radius: 2.0, x: 2.0, y: 4.0)
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
       // .scaleEffect()
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
