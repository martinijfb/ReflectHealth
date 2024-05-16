//
//  ScannerViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 01/05/2024.
//

import SwiftUI
import RealityKit
import ARKit


struct ScannerViewModelOld: UIViewRepresentable {
    
    @Binding var status: String
    @Binding var matrix: simd_float4x4
    @Binding var shouldRestartSession: Bool
    @Binding var shouldPauseSession: Bool
    @Binding var shouldStartSession: Bool
    @Binding var imageData: [Data]
    @Binding var didInitiallyCalibrate: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if shouldRestartSession {
            uiView.session.pause()
            let configuration = ARFaceTrackingConfiguration()
            uiView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            DispatchQueue.main.async {
                shouldRestartSession = false
            }
        }
        
        if shouldPauseSession {
            uiView.session.pause()
            DispatchQueue.main.async {
                didInitiallyCalibrate = false
            }
        }
        
        if shouldStartSession {
            let configuration = ARFaceTrackingConfiguration()
            uiView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            DispatchQueue.main.async {
                shouldPauseSession = false
                shouldStartSession = false
                didInitiallyCalibrate = false
            }
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(status: $status, matrix: $matrix, imageData: $imageData, didInitiallyCalibrate: $didInitiallyCalibrate)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        @Binding var matrix: simd_float4x4
        @Binding var status: String
        @Binding var imageData: [Data]
        @Binding var didInitiallyCalibrate: Bool
        private var isProcessingImage = false
        
        init(status: Binding<String>, matrix: Binding<simd_float4x4>, imageData: Binding<[Data]>, didInitiallyCalibrate: Binding<Bool>) {
            _status = status
            _matrix = matrix
            _imageData = imageData
            _didInitiallyCalibrate = didInitiallyCalibrate
        }
        
        
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let faceAnchor = anchor as? ARFaceAnchor {
                    let roll = faceAnchor.transform.columns.2.x
                    let xTranslation = faceAnchor.transform.columns.0.w
                    let yTranslation = faceAnchor.transform.columns.1.w
                    self.matrix = faceAnchor.transform

                    if imageData.isEmpty
                        && didInitiallyCalibrate
                        && !isProcessingImage
                        && roll > 0.5
                        && xTranslation > -0.03
                        && xTranslation < 0.03
                        && yTranslation > -0.03 
                        && yTranslation < 0.03 {
                            isProcessingImage = true
                            if let frame = session.currentFrame {
                                takeSnapshot(frame: frame)
                            }
                        }
    
                    else if imageData.count == 1
                                && !isProcessingImage
                                && roll < -0.5
                                && xTranslation > -0.03
                                && xTranslation < 0.03 
                                && yTranslation > -0.03
                                && yTranslation < 0.03 {
                        isProcessingImage = true
                        if let frame = session.currentFrame {
                            takeSnapshot(frame: frame)
                        }
                    }

                    else if imageData.count == 2
                                && !isProcessingImage
                                && roll > -0.01
                                && roll < 0.01
                                && xTranslation > -0.03
                                && xTranslation < 0.03
                                && yTranslation > -0.03
                                && yTranslation < 0.03  {
                        
                        isProcessingImage = true
                        if let frame = session.currentFrame {
                            takeSnapshot(frame: frame)
                        }
                    }
        
                }
            }
            DispatchQueue.main.async {
                self.updateStatus()
            }
        }
        
        func updateStatus() {
            if imageData.isEmpty && !didInitiallyCalibrate {
                status = "Please calibrate"
            } else if imageData.isEmpty && didInitiallyCalibrate {
                status = "Slowly, look towards your right"
            } else if imageData.count == 1 && didInitiallyCalibrate {
                status = "Slowly, look towards your left"
            } else if imageData.count == 2 && didInitiallyCalibrate {
                status = "Slowly, look towards the camera"
            } else if imageData.count == 3 && didInitiallyCalibrate {
                status = "Scan Completed"
            }
        }
        
        func takeSnapshot(frame: ARFrame) {
            DispatchQueue.global(qos: .userInitiated).async {
                let ciImage = CIImage(cvPixelBuffer: frame.capturedImage)
                
                // Determine the current device orientation
                let deviceOrientation = UIDevice.current.orientation
                let ciOrientation = self.ciImageOrientation(from: deviceOrientation)
                
                // Apply orientation to CIImage
                let orientedCIImage = ciImage.oriented(forExifOrientation: ciOrientation)
                
                let context = CIContext(options: nil)
                guard let cgImage = context.createCGImage(orientedCIImage, from: orientedCIImage.extent) else {
                    DispatchQueue.main.async {
                        self.isProcessingImage = false // Reset flag if image creation fails
                    }
                    return
                }
                
                let uiImage = UIImage(cgImage: cgImage)
                if let safeData = uiImage.pngData() {
                    DispatchQueue.main.async {
                        self.imageData.append(safeData)
                        self.isProcessingImage = false // Reset flag after image is added
                    }
                }
            }
        }
        
        func ciImageOrientation(from deviceOrientation: UIDeviceOrientation) -> Int32 {
            switch deviceOrientation {
            case .portrait:
                return 6 // kCGImagePropertyOrientationRight
            case .portraitUpsideDown:
                return 8 // kCGImagePropertyOrientationLeft
            case .landscapeLeft:
                return 1 // kCGImagePropertyOrientationUp
            case .landscapeRight:
                return 3 // kCGImagePropertyOrientationDown
            default:
                return 1 // Default to original
            }
        }
    }
}
