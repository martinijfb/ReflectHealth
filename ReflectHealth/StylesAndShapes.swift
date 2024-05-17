//
//  Styles.swift
//  ReflectHealth
//
//  Created by Martin on 17/05/2024.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white) // Set the text color to white
            .padding(.vertical, 6)
            .padding(.horizontal) // Add padding around the text to increase button size
            .background(Color.accentColor) // Use the accent color for the background
            .clipShape(Capsule()) // Clip the view to a capsule shape
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Optional: Change scale on press for a slight animation
    }
}

struct TopRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Starting from the top left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))

        // Top left corner
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))

        // Top right corner
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(270),
                    endAngle: .degrees(0),
                    clockwise: false)

        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // Bottom right corner (no rounding)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // Bottom edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        // Bottom left corner (no rounding)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        // Close the path by linking back to the start point
        path.closeSubpath()

        return path
    }
}
