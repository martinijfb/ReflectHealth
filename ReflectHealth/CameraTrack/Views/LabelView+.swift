//
//  LabelView+.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

extension LabelView {
    internal func displayedImage(_ uiImage: UIImage) -> some View {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .overlay(
                    textEditorInFocus ? nil :
                    GeometryReader { imageGeometry in
                        CanvasView(
                            canvasView: $vm.canvasView,
                            rect: imageGeometry.frame(in: .local),
                            toolType: vm.toolType,
                            color: UIColor(vm.selectedColor)
                        )
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
        }
    
    internal var toolbarCameraButton: some View {
        Button {
            showCamera = true
        } label: {
            Image(systemName: "camera.fill")
        }
    }
    
    internal var openCameraButton: some View {
        VStack {
            Button {
                showCamera = true
            } label: {
                Image(systemName: "camera.aperture")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 100, height: 100)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            Text("Open the Camera")
                .font(.headline)
                .padding()
        }
    }
    
    @ViewBuilder
    internal func textEditorSection() -> some View {
        HStack {
            TextEditor(text: self.$textEditorText)
                    .focused($textEditorInFocus)
                    .foregroundStyle(self.textEditorText == placeholderString ? .secondary : .primary)
                          .onTapGesture {
                            if self.textEditorText == placeholderString {
                              self.textEditorText = ""
                            }
                          }
                          .frame(height: 80)
                          .colorMultiply(Color(uiColor: .systemGray6))
                      .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            if textEditorInFocus {
                Button {
                    textEditorInFocus = false
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.largeTitle)
                }
            }

        }
    }

}
