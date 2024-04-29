//
//  CameraView+Buttons.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

extension CameraView {
    internal var usePhotoButton: some View {
        ControlButtonView(label: "Use Photo") {
            if let data = vm.photoData {
                imageData.append(data)
            }
            if imageData.count >= 3 {
                showCamera = false
            } else {
                vm.retakePhoto()
            }
        }
    }
    
    internal var retakeButton: some View {
        ControlButtonView(label: "Retake") {
            vm.retakePhoto()
        }
    }
    
    internal var cancelButton: some View {
        Button {
            showCamera = false
        } label: {
            Image(systemName: "xmark")
                .tint(.white)
                .font(.title)
                .fontWeight(.semibold)
        }

    }
    
    internal var switchCameraButton: some View {
        Button {
            vm.switchCamera()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath.camera")
                .tint(.white)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
    
    internal var photoCaptureButton: some View {
        Button {
            vm.takePhoto()
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 65)
                Circle()
                    .stroke(.white, lineWidth: 3)
                    .frame(width: 75)
            }
        }

    }
}
