//
//  LabelViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import PencilKit
import SwiftData

@Observable
class LabelViewModel: ObservableObject {
    
    var imageData: [Data] = []
//    var imageData: [Data] = [
//        UIImage(named: "pikachu")!.pngData()!,
//        UIImage(named: "charizard")!.pngData()!,
//        UIImage(named: "rayquaza")!.pngData()!,
//    ]

    var showCamera: Bool = false
    var showScanner: Bool = false
    var showSavedSheet: Bool = false
    var textEditorText: String = "Add notes here ..."
    var selectedTab: Int = 0
    
    var canvasViewLeft = PKCanvasView()
    var canvasViewRight = PKCanvasView()
    var canvasViewFront = PKCanvasView()
    var selectedColor: Color = .indigo
    var toolType: ToolTypeOld = .pen
    var placeholderString: String = "Add notes here ..."
    

    
    func openCamera() {
        showCamera = true
    }
    
    func deleteRecordedData() {
        imageData.removeAll()
        textEditorText = placeholderString
        clearCanvas(on: canvasViewLeft)
        clearCanvas(on: canvasViewRight)
        clearCanvas(on: canvasViewFront)
    }
    
    func undo(on canvas: PKCanvasView) {
            if canvas.undoManager?.canUndo == true {
                canvas.undoManager?.undo()
            }
        }
    
    func clearTextEditor() {
        if textEditorText == placeholderString {
            textEditorText = ""
        }
    }
    
    func validateTextEditor() {
        if textEditorText.isEmpty {
            textEditorText = placeholderString
        }
    }
    
    func clearCanvas(on canvasView: PKCanvasView) {
        canvasView.drawing = PKDrawing()
    }
    
    func pkDrawingToUIImage(drawing: PKDrawing, size: CGSize, scale: CGFloat = 1.0) -> UIImage {
        return drawing.image(from: CGRect(origin: .zero, size: size), scale: scale)
    }

    // After getting the correct size, convert the PKDrawing to image data
    func convertDrawingToImageData(canvasView: PKCanvasView) -> Data? {
        // Get the current size of the canvas view
        let canvasSize = canvasView.frame.size
        
        // Convert the PKDrawing to UIImage with the same size as the overlayed image
        let drawingImage = pkDrawingToUIImage(drawing: canvasView.drawing, size: canvasSize)

        // Convert UIImage to PNG data
        return drawingImage.pngData()
    }
    
}
