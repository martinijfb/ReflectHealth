//
//  LabelViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import PencilKit

@Observable
class LabelViewModel: ObservableObject {
    
    
//    var imageData: [Data] = []
    var imageData: [Data] = [
        UIImage(named: "pikachu")!.pngData()!,
        UIImage(named: "pikachu")!.pngData()!,
        UIImage(named: "pikachu")!.pngData()!,
    ]
//    var imageData: Data? = UIImage(named: "pikachu")?.pngData()
    var showCamera: Bool = false
    var textEditorText: String = "Add notes here ..."
    
    
    var canvasViewLeft = PKCanvasView()
    var canvasViewRight = PKCanvasView()
    var canvasViewFront = PKCanvasView()
    var selectedColor: Color = .accentColor
    var toolType: ToolType = .pen
    var placeholderString: String = "Add notes here ..."
    
    func openCamera() {
        showCamera = true
    }
    
    func deleteRecordedData() {
        imageData.removeAll()
        textEditorText = placeholderString
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
    
    func saveRecordedData() {
        return
    }
}
