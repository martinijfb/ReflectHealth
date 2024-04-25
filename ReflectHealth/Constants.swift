//
//  Constants.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//


import SwiftUI

struct Gradients {
    static let customGradient = LinearGradient(
        colors: [Color.accentColor.opacity(0.1), Color.blue.opacity(0.2)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let customGradientInverse = LinearGradient(
        colors: [Color.blue.opacity(0.2), Color.accentColor.opacity(0.1)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let customGradientSheet = LinearGradient(
        colors: [Color.blue, Color.accentColor],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

