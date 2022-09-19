//
//  DashboardButtons.swift
//  
//
//  Created by Paull Stanley on 9/19/22.
//

import SwiftUI

public struct DashboardButtons {
    public init(symbol: String, label: String, color: AnyGradient) {
        self.symbol = symbol
        self.label = label
        self.color = color
    }
    
    public var symbol: String
    public var label: String
    public var color: AnyGradient
}
