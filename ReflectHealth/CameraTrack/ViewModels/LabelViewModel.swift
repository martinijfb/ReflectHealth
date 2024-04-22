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
    
    var imageData: Data? = nil
    var showCamera: Bool = false
    var textEditorText: String = "Add notes here ..."

    
    var canvasView = PKCanvasView()
    var selectedColor: Color = .accentColor
    var toolType: ToolType = .pen
    var placeholderString: String = "Add notes here ..."
    
    func openCamera() {
        showCamera = true
    }
    
    func undo() {
        if canvasView.undoManager?.canUndo == true {
            canvasView.undoManager?.undo()
        }
    }
    
    func clearTextEditor() {
        if textEditorText == placeholderString {
            textEditorText = ""
        }
    }
    
    func clearCanvas() {
        canvasView.drawing = PKDrawing()
    }
}
