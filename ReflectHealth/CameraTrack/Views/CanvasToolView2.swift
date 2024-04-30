//
//  CanvasToolView2.swift
//  ReflectHealth
//
//  Created by Martin on 29/04/2024.
//

import Foundation
import SwiftUI
import PencilKit

struct CanvasToolsView2: View {
    @Binding var toolType: ToolType
    var undo: () -> Void
    var clearCanvas: () -> Void
    var frameSize: CGFloat = 30
    
    var body: some View {
        
        HStack(spacing: 20) {
            Group {
                Button(action: undo) {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.green)
                }
                
                Button {
                    toolType = .pen
                } label: {
                    Image(systemName: "pencil.tip.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(toolType == .pen ? .indigo : .gray)
                    
                }
                
                Button {
                    toolType = .eraser
                } label: {
                    Image("eraser.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(toolType == .eraser ? .indigo : .gray)
                }
                
                
                Button(action: clearCanvas) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.red)
                }
            }
            .frame(width: frameSize, height: frameSize)
        }
        .font(.caption)
        .padding(8)
        .background(.ultraThinMaterial)
        .background(Gradients.customGradient)
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .padding()
    }
}

struct CanvasToolsView2_Previews: PreviewProvider {
    @State static var toolType: ToolType = .pen
    
    static var previews: some View {
        CanvasToolsView2(
            toolType: $toolType,
            undo: { print("Undo") },
            clearCanvas: { print("Clear Canvas") }
        )
    }
}
