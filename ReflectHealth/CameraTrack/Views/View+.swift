//
//  View+.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

extension View {
    func fullScreenCamera(isPresented: Binding<Bool>, imageData: Binding<[Data]>) -> some View {
        self
            .fullScreenCover(isPresented: isPresented, content: {
                CameraView(imageData: imageData, showCamera: isPresented)
            })
    }
}
