//
//  CameraViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import AVFoundation
import Foundation
import UIKit
import SwiftUI

@Observable
class CameraViewModel: NSObject {
    
    enum PhotoCaptureState {
        case notStarted
        case processing
        case finished(Data)
    }
    
    var session = AVCaptureSession()
    var preview = AVCaptureVideoPreviewLayer()
    var output = AVCapturePhotoOutput()
    var currentCameraPosition: AVCaptureDevice.Position = .front
    
    var photoData: Data? {
        if case .finished(let data) = photoCaptureState {
            return data
        }
        return nil
    }
    
    var hasPhoto: Bool { photoData != nil }
    
    private(set) var photoCaptureState: PhotoCaptureState = .notStarted
    
    func requestAccessAndSetup() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { didAllowAccess in
                self.setup()
            }
        case .authorized:
            setup()
            
        default:
            print("other status")
        }
        
    }
    
    private func setup() {
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        let initialCameraPosition: AVCaptureDevice.Position = .front
        
        do {
            guard let device = cameraWithPosition(initialCameraPosition) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input) else { return }
            session.addInput(input)
            
            guard session.canAddOutput(output) else { return }
            session.addOutput(output)
            
            session.commitConfiguration()
            
            Task(priority: .background) {
                self.session.startRunning()
            }
            
        } catch {
            
            print(error.localizedDescription)
        }
        
    }
    
    private func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified).devices
        return devices.first(where: { $0.position == position })
    }
    
    
    func switchCamera() {
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        
        session.beginConfiguration()
        session.removeInput(currentInput)
        
        currentCameraPosition = (currentCameraPosition == .back) ? .front : .back
        
        guard let newCamera = cameraWithPosition(currentCameraPosition) else {
            print("Could not find camera for position \(currentCameraPosition)")
            return
        }
        
        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if session.canAddInput(newInput) {
                session.addInput(newInput)
            } else {
                print("Could not add new camera input to the session")
            }
        } catch let error {
            print("Error switching cameras: \(error.localizedDescription)")
        }
        
        session.commitConfiguration()
        Task(priority: .background) {
            session.startRunning()
        }
    }
    
    
    
    func takePhoto() {
        guard case .notStarted = photoCaptureState else {
            return
        }
        
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        withAnimation {
            self.photoCaptureState = .processing
        }
    }
    
    func retakePhoto() {
        Task(priority: .background) {
            self.session.startRunning()
            await MainActor.run {
                withAnimation {
                    self.photoCaptureState = .notStarted
                }
            }
        }
    }
    
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    // MIRRORING THE IMAGE
    //    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
    //        if let error {
    //            print(error.localizedDescription)
    //        }
    //
    //        guard let imageData = photo.fileDataRepresentation() else { return }
    //
    //        // Create a UIImage from the data
    //        guard let originalImage = UIImage(data: imageData) else { return }
    //
    //        // Flip the image horizontally if using front camera
    //        let finalImage = (currentCameraPosition == .front) ? originalImage.flippedHorizontally() : originalImage
    //
    //        // Create data from flipped image
    //        guard let finalImageData = finalImage.pngData() else { return }
    //
    //        Task(priority: .background) {
    //            self.session.stopRunning()
    //            await MainActor.run {
    //                withAnimation {
    //                    self.photoCaptureState = .finished(finalImageData)
    //                }
    //            }
    //        }
    //    }
    
    // WITHOUT MIRRORING THE IMAGE
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        if let error {
            print(error.localizedDescription)
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        Task(priority: .background) {
            self.session.stopRunning()
            await MainActor.run {
                withAnimation {
                    self.photoCaptureState = .finished(imageData)
                }
            }
        }
    }
    
    
}

extension UIImage {
    // Function to flip the image horizontally
    func flippedHorizontally() -> UIImage {
        let flippedImage = UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: .leftMirrored)
        return flippedImage
    }
}
