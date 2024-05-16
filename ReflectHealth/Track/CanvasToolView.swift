//
//  CanvasToolView.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import Foundation
import SwiftUI
import PencilKit

struct CanvasToolsView: View {
    
    @Binding var toolType: ToolType
    var undo: () -> Void
    var clearCanvas: () -> Void
    var frameSize: CGFloat = 30
    
    var body: some View {
        
        HStack(spacing: 20) {
            Group {
                undoButton
                penButton
                eraserButton
                clearCanvasButton
            }
            .frame(width: frameSize, height: frameSize)
        }
        .font(.caption)
        .padding(8)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: frameSize))
        .padding()
    }
}

extension CanvasToolsView {
    
    var undoButton: some View {
        Button(action: undo) {
            Image(systemName: "arrow.uturn.backward.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.green)
        }
    }
    
    var penButton: some View {
        Button {
            toolType = .pen
        } label: {
            Image(systemName: "pencil.tip.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(toolType == .pen ? .indigo : .gray)
            
        }
    }
    
    var eraserButton: some View {
        Button {
            toolType = .eraser
        } label: {
            Image("eraser.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(toolType == .eraser ? .indigo : .gray)
        }
    }
    
    var clearCanvasButton: some View {
        Button(action: clearCanvas) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.red)
        }
    }
}

#Preview {
    @State var toolType: ToolType = .pen
    return CanvasToolsView(
        toolType: $toolType,
        undo: { print("Undo") },
        clearCanvas: { print("Clear Canvas") }
    )
}
