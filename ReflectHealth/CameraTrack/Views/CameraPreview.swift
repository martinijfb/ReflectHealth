//
//  CameraPreview.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @Binding var cameraVM: CameraViewModel
    let frame: CGRect
    
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: frame)
        cameraVM.preview = AVCaptureVideoPreviewLayer(session: cameraVM.session)
        cameraVM.preview.frame = frame
        cameraVM.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraVM.preview)
        
        
        if let image = UIImage(named: "scanner-frame-white") {
            let imageLayer = CALayer()
            imageLayer.contents = image.cgImage
            imageLayer.frame = view.bounds // adjust according to your needs
            imageLayer.contentsGravity = .resizeAspectFill
            view.layer.addSublayer(imageLayer)
        }
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
