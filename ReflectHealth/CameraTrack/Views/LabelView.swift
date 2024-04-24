//
//  LabelView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import PencilKit

struct LabelView: View {
    @State internal var vm = LabelViewModel()
    @FocusState internal var textEditorInFocus: Bool
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if vm.imageData.count >= 3 {
 
                    if !textEditorInFocus {
                        let currentCanvas = currentCanvasView(selectedTab: selectedTab)
                        CanvasToolsView(
                            toolType: $vm.toolType,
                            selectedColor: $vm.selectedColor,
                            undo: { vm.undo(on: currentCanvas) },
                            clearCanvas: { vm.clearCanvas(on: currentCanvas) }
                        )
                    }
                    
                    
                    switch selectedTab {
                    case 0:
                        if let uiImage = UIImage(data: vm.imageData[0]) {
                            displayedImageLeft(uiImage)
                        }
                    case 1:
                        if let uiImage = UIImage(data: vm.imageData[1]) {
                            displayedImageRight(uiImage)
                        }
                    case 2:
                        if let uiImage = UIImage(data: vm.imageData[2]) {
                            displayedImageFront(uiImage)
                        }
                    default:
                        Text("Not images were found")
                    }
                    
                    
                    HStack {
                        Spacer()
                        Text("Select an image to label:")
                            .fontWeight(.semibold)
                        Spacer()
                        Picker("Select Image to Label", selection: $selectedTab) {
                            Text("Left").tag(0)
                            Text("Right").tag(1)
                            Text("Front").tag(2)
                        }
                        .pickerStyle(.menu)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    textEditorSection()
                    
                } else {
                    openCameraButton
                }
            }
            .padding()
            .navigationTitle("Track")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
        }
    }
    
    private func currentCanvasView(selectedTab: Int) -> PKCanvasView {
            switch selectedTab {
            case 0:
                return vm.canvasViewLeft
            case 1:
                return vm.canvasViewRight
            case 2:
                return vm.canvasViewFront
            default:
                return PKCanvasView() // fallback if needed
            }
        }
}



#Preview {
    LabelView()
}
