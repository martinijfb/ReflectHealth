//
//  ScannerViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import SwiftUI
import simd
import PencilKit

@Observable
class ScannerViewModel {
    var status: String = "Please calibrate"
    var matrix: simd_float4x4 = simd_float4x4()
    var shouldRestartSession: Bool = false
    var shouldPauseSession: Bool = false
    var shouldStartSession: Bool = false
    var imageData: [Data] = []
    var didInitiallyCalibrate: Bool = false

    var selectedTab: Int = 0
    var canvasViewLeft = PKCanvasView()
    var canvasViewRight = PKCanvasView()
    var canvasViewFront = PKCanvasView()
    var selectedColor: Color = .indigo
    var toolType: ToolType = .pen
    var showSavedSheet: Bool = false
    
    var textEditorText: String = ""
    
    func undo(on canvas: PKCanvasView) {
        if canvas.undoManager?.canUndo == true {
            canvas.undoManager?.undo()
        }
    }
    
    func clearCanvas(on canvasView: PKCanvasView) {
        canvasView.drawing = PKDrawing()
    }
    
    
    func pkDrawingToUIImage(drawing: PKDrawing, size: CGSize, scale: CGFloat = 1.0) -> UIImage {
        return drawing.image(from: CGRect(origin: .zero, size: size), scale: scale)
    }
    

    func convertDrawingToImageData(canvasView: PKCanvasView) -> Data? {
        let canvasSize = canvasView.frame.size
        let drawingImage = pkDrawingToUIImage(drawing: canvasView.drawing, size: canvasSize)
        return drawingImage.pngData()
    }
    
    func deleteRecordedData() {
        imageData.removeAll()
        textEditorText = ""
        clearCanvas(on: canvasViewLeft)
        clearCanvas(on: canvasViewRight)
        clearCanvas(on: canvasViewFront)
    }
}
