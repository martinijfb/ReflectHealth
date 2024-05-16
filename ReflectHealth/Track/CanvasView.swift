//
//  CanvasView.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    var rect: CGRect
    var toolType: ToolType
    var color: UIColor
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        canvasView.frame = rect
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        canvasView.frame = rect
        switch toolType {
        case .pen:
            canvasView.tool = PKInkingTool(.monoline, color: color, width: 2)
        case .eraser:
            canvasView.tool = PKEraserTool(.bitmap)
        }
    }
}
