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
        ZStack(alignment: .top) {
            
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                cameraPreview
                controlBar
                    .frame(height: controlFrameHeight)
            }
            cameraFaceSideSelector(imageData: imageData)
        }
    }
    
    @ViewBuilder
    func cameraFaceSideSelector(imageData: [Data]) -> some View {
        HStack {
            if imageData.isEmpty {
                Text("Left side of your face")
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if imageData.count == 1 {
                Text("Right side of your face")
                    .font(.title3)
                    .fontWeight(.semibold)
            } else {
                Text("Front of your face")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.vertical)
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
