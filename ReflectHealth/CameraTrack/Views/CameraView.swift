//
//  CameraView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct CameraView: View {

    
    @State internal var vm = CameraViewModel()
    
    @Binding var imageData: [Data]
    @Binding var showCamera: Bool
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                cameraPreview
                controlBar
                    .frame(height: controlFrameHeight)
            }
            
        }
    }
    
    
    private var cameraPreview: some View {
        
        GeometryReader { geo in
            CameraPreview(cameraVM: $vm, frame: geo.frame(in: .global))
                .onAppear() {
                    vm.requestAccessAndSetup()
                }
        }
        .ignoresSafeArea()
    }
    
    
}

//#Preview {
//    CameraView(imageData: .constant(nil), showCamera: .constant(true))
//}
