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
    
    
    //    var imageData: Data? = nil
    var imageData: Data? = UIImage(named: "pikachu")?.pngData()
    var showCamera: Bool = false
    var textEditorText: String = "Add notes here ..."
    
    
    var canvasView = PKCanvasView()
    var selectedColor: Color = .accentColor
    var toolType: ToolType = .pen
    var placeholderString: String = "Add notes here ..."
    
    func openCamera() {
        showCamera = true
    }
    
    func deleteRecordedData() {
        imageData = nil
        textEditorText = placeholderString
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
    
    func validateTextEditor() {
        if textEditorText.isEmpty {
            textEditorText = placeholderString
        }
    }
    
    func clearCanvas() {
        canvasView.drawing = PKDrawing()
    }
    
    func saveRecordedData() {
        return
    }
}
