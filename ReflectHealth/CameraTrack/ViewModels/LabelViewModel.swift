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
    
    var canvasView = PKCanvasView()
    var selectedColor: Color = .accentColor
    var toolType: ToolType = .pen

    func undo() {
        if canvasView.undoManager?.canUndo == true {
            canvasView.undoManager?.undo()
        }
    }

    func clearCanvas() {
        canvasView.drawing = PKDrawing()
    }
}
