//
//  LabelView.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import SwiftUI

struct LabelView: View {
    @Environment(\.dismiss) internal var dismiss
    @Environment(\.modelContext) var modelContext
    @Binding var vm: ScannerViewModel
    @FocusState internal var textEditorInFocus: Bool
    
    var body: some View {
        VStack {
            if vm.imageData.count >= 3 {
                ZStack(alignment: .top) {
                    
                    // Display an image and canvas depending on picker value
                    getTabContent(selectedTab: vm.selectedTab)
                    
                    // Show Labelling Toolbar when not using keyboard
                    if !textEditorInFocus {
                        let currentCanvas = currentCanvasView(selectedTab: vm.selectedTab)
                        CanvasToolsView(
                            toolType: $vm.toolType,
                            undo: { vm.undo(on: currentCanvas) },
                            clearCanvas: { vm.clearCanvas(on: currentCanvas) }
                        )
                    }
                }
            }

            imageToLabelPicker(selectedTab: $vm.selectedTab)
            textEditorSection
            
        }
        .padding()
        .navigationTitle("Track")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                deleteRecordedDataButton
            }
            
            ToolbarItem(placement: .topBarLeading) {
                saveRecordedDataButton
            }
        }
        .fullScreenCover(isPresented: $vm.showSavedSheet, content: {
            savedTrackDataSheet
        })
    }
}

#Preview {
    @State var vm = ScannerViewModel()
    let imageData: [Data] = [
                UIImage(named: "pikachu")!.pngData()!,
                UIImage(named: "charizard")!.pngData()!,
                UIImage(named: "rayquaza")!.pngData()!
    ]
    vm.imageData.append(contentsOf: imageData)
    return NavigationStack {
        LabelView(vm: $vm)
    }
}

#Preview {
    @State var vm = ScannerViewModel()
    return NavigationStack {
        LabelView(vm: $vm)
    }
}
