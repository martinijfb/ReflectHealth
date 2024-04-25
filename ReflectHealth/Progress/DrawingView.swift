//
//  LoadedCanvasView.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    var canvasView = PKCanvasView()
    var rect: CGRect
    var drawingData: Data
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        canvasView.frame = rect
        if let savedDrawing = try? PKDrawing(data: drawingData) {
            canvasView.drawing = savedDrawing
        }
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        canvasView.frame = rect
    }
}
