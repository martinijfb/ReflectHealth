//
//  LabelView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct LabelView: View {
    @State internal var vm = LabelViewModel()
    @FocusState internal var textEditorInFocus: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageData = vm.imageData, let uiImage = UIImage(data: imageData) {
                    
                    if !textEditorInFocus {
                        CanvasToolsView(vm: $vm)
                    }
                    displayedImage(uiImage)
                    textEditorSection()
                    
                } else {
                    openCameraButton
                }
            }
            .padding()
            .navigationTitle("Track")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if vm.imageData != nil {
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
}



#Preview {
    LabelView()
}
