//
//  CameraView+ControlBar.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

extension CameraView {
    
    @ViewBuilder var controlBar: some View {
        if vm.hasPhoto {
            controlBarPostPhoto
        } else {
            controlBarPrePhoto
        }
    }

    internal var controlBarPrePhoto: some View {
        HStack {
            cancelButton
                .frame(width: controlButtonWidth)
            Spacer()
            photoCaptureButton
            Spacer()
            switchCameraButton
                .frame(width: controlButtonWidth)
        }
        .padding(.top)
    }

    internal var controlBarPostPhoto: some View {
        HStack {
            retakeButton
                .frame(width: controlButtonWidth)
            Spacer()
            usePhotoButton
                .frame(width: controlButtonWidth)
        }
        .padding(.top)
    }
}
