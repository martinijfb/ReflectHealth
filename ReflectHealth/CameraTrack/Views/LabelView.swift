//
//  LabelView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct LabelView: View {
    @State internal var vm = LabelViewModel()
    @State private var imageData: Data? = nil
    @State internal var showCamera: Bool = false
    @State internal var placeholderString: String = "Add notes here ..."
    @State internal var textEditorText: String = "Add notes here ..."
    @FocusState internal var textEditorInFocus: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
//                if let uiImage = UIImage(named: "pikachu") {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    
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
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarCameraButton
                }
            }
            .fullScreenCamera(isPresented: $showCamera, imageData: $imageData)
        }
    }
}



#Preview {
    LabelView()
}
