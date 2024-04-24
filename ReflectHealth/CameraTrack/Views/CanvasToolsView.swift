//
//  CanvasToolsView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import PencilKit

struct CanvasToolsView: View {
    
    @Binding var toolType: ToolType
    @Binding var selectedColor: Color
    var undo: () -> Void
    var clearCanvas: () -> Void
    
    var body: some View {
        
        HStack(spacing: 40) {
            Button(action: undo) {
                Image(systemName: "arrow.uturn.left")
                    .font(.title)
                    .foregroundColor(.green)
            }
            
            Button {
                toolType = .pen
            } label: {
                Image(systemName: "pencil.and.outline")
                    .font(.title)
                    .foregroundStyle(toolType == .pen ? selectedColor : .gray.opacity(0.5))
            }
            
            Button {
                toolType = .eraser
            } label: {
                Image(systemName: "eraser.line.dashed")
                    .font(.title)
                    .foregroundStyle(toolType == .eraser ? .indigo : .gray.opacity(0.5))
            }
            
            ColorPicker("Color", selection: $selectedColor, supportsOpacity: false)
                .labelsHidden()
                .disabled(toolType == .eraser)
            
            Button(action: clearCanvas) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}

//#Preview {
//    CanvasToolsView(currentCanvas: <#T##PKCanvasView#>, selectedColor: <#T##Color#>, toolType: <#T##Binding<ToolType>#>, undo: <#T##() -> Void#>, clearCanvas: <#T##() -> Void#>) // Use a constant binding
//}
