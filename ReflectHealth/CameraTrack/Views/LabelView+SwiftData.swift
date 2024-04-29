//
//  LabelView+SwiftData.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import Foundation

extension LabelView {
    internal func saveRecordedData() {
        
        var notes: String {
            if vm.textEditorText == vm.placeholderString {
                return ""
            } else {
                return vm.textEditorText
            }
        }
        
        let trackedData = TrackedData(
            image1: vm.imageData[0],
            image2: vm.imageData[1],
            image3: vm.imageData[2],
            drawing1: vm.convertDrawingToImageData(canvasView: vm.canvasViewLeft),
            drawing2: vm.convertDrawingToImageData(canvasView: vm.canvasViewRight),
            drawing3: vm.convertDrawingToImageData(canvasView: vm.canvasViewFront),
            
            notes: notes)
        
        modelContext.insert(trackedData)
        
        vm.deleteRecordedData() // Clear the view
        vm.showSavedSheet = true
    }
    
    
}
