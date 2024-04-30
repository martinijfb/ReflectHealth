//
//  LabelView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct LabelView: View {
    @Environment(\.modelContext) var modelContext
    @State internal var vm = LabelViewModel()
    @FocusState internal var textEditorInFocus: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Gradients.customGradient.ignoresSafeArea()
                VStack {
                    // Show all this if there is image data
                    if vm.imageData.count >= 3 {
                        
                        ZStack(alignment: .top) {
                            // Display an image and canvas depending on picker value
                            getTabContent(selectedTab: vm.selectedTab)
                            // Show Labelling Toolbar when not using keyboard
                            if !textEditorInFocus {
                                let currentCanvas = currentCanvasView(selectedTab: vm.selectedTab)
                                CanvasToolsView2(
                                    toolType: $vm.toolType,
                                    undo: { vm.undo(on: currentCanvas) },
                                    clearCanvas: { vm.clearCanvas(on: currentCanvas) }
                                )
                            }
                        }
                        
                        // Display Picker
                        imageToLabelPicker(selectedTab: $vm.selectedTab)
                        
                        // Display the Texfield
                        textEditorSection()
                        
                    } else {
                        // Display the camera button if there is no image data
                        openCameraButton
                    }
                }
                .padding()
                .navigationTitle("Track")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Allow these options just when there is image data
                    if !vm.imageData.isEmpty {
                        ToolbarItem(placement: .topBarTrailing) {
                            deleteRecordedDataButton
                        }
                        
                        ToolbarItem(placement: .topBarLeading) {
                            saveRecordedDataButton
                        }
                    }
                }
                .fullScreenCamera(isPresented: $vm.showCamera, imageData: $vm.imageData)
                .sheet(isPresented: $vm.showSavedSheet, content: {
                    savedTrackDataSheet
            })
            }
        }
    }
}



#Preview {
    LabelView()
}
