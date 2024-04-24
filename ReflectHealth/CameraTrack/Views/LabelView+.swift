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
    
    internal var deleteRecordedDataButton: some View {
        Button {
            vm.deleteRecordedData()
        } label: {
            Image(systemName: "trash")
        }
    }
    
    internal var saveRecordedDataButton: some View {
        Button("Save") {
            vm.saveRecordedData()
        }
    }
    
    internal var openCameraButton: some View {
        VStack {
            Text("Let's track your progress ⌛️")
                .font(.callout)
                .padding()
            
            Button {
                vm.openCamera()
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
        VStack {
            HStack {
                Text("Notes")
                    .fontWeight(.semibold)
                Spacer()
            }
            HStack {
                TextEditor(text: $vm.textEditorText)
                    .focused($textEditorInFocus)
                    .foregroundStyle(vm.textEditorText == vm.placeholderString ? .secondary : .primary)
                    .onTapGesture {
                        vm.clearTextEditor()
                    }
                    .onChange(of: textEditorInFocus) {
                        if !textEditorInFocus {
                            vm.validateTextEditor()
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
}

#Preview {
    LabelView()
}
