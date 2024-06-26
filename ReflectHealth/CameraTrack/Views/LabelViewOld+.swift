//
//  LabelView+.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import PencilKit

extension LabelViewOld {
    internal func displayedImageLeft(_ uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .overlay(
                textEditorInFocus ? nil :
                    GeometryReader { imageGeometry in
                        CanvasViewOld(
                            canvasView: $vm.canvasViewLeft,
                            rect: imageGeometry.frame(in: .local),
                            toolType: vm.toolType,
                            color: UIColor(vm.selectedColor)
                        )
                    }
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    internal func displayedImageRight(_ uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .overlay(
                textEditorInFocus ? nil :
                    GeometryReader { imageGeometry in
                        CanvasViewOld(
                            canvasView: $vm.canvasViewRight,
                            rect: imageGeometry.frame(in: .local),
                            toolType: vm.toolType,
                            color: UIColor(vm.selectedColor)
                        )
                    }
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    internal func displayedImageFront(_ uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .overlay(
                textEditorInFocus ? nil :
                    GeometryReader { imageGeometry in
                        CanvasViewOld(
                            canvasView: $vm.canvasViewFront,
                            rect: imageGeometry.frame(in: .local),
                            toolType: vm.toolType,
                            color: UIColor(vm.selectedColor)
                        )
                    }
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
            saveRecordedData()
        }
    }
    
    internal var openCameraButton: some View {
            VStack {
                Text("Let's track your progress ⌛️")
                    .font(.callout)
                    .padding()
                
                Menu {
                    Button("Scanner", systemImage: "camera.metering.matrix") {
                        vm.showScanner = true
                        vm.imageData.removeAll()
                    }
                    Button("Camera", systemImage: "camera.fill") {
                        vm.openCamera()
                        vm.imageData.removeAll()
                    }

                } label: {
                    Image(systemName: "camera.aperture")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 100, height: 100)
                        .background(Gradients.customGradientInverse)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }

                
    //            Button {
    //                vm.openCamera()
    //                vm.imageData.removeAll()
    //            } label: {
    //                Image(systemName: "camera.aperture")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .padding()
    //                    .frame(width: 100, height: 100)
    //                    .background(Gradients.customGradientInverse)
    //                    .background(.ultraThinMaterial)
    //                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                    
                    
    //                ZStack {
    //                    Image("person-outline")
    //                        .resizable()
    //                        .scaledToFit()
    //                        .foregroundStyle(.indigo)
    //
    //                    Image("scanner-frame")
    //                        .resizable()
    //                        .scaledToFit()
    //                        .foregroundStyle(.accent)
    //
    //                }
    //                .padding()
    //                .frame(width: 300)
    //                .background(Gradients.customGradientInverse)
    //                .background(.ultraThinMaterial)
    //                .clipShape(RoundedRectangle(cornerRadius: 10.0))
    //            }
                Text("Open the Camera")
                    .font(.headline)
                    .padding()
                
            }
        
        
//        VStack {
//
//                ZStack {
//                    Image("person-outline")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(.indigo)
//
//                    Image("scanner-frame")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(.accent)
//
//                }
//                .frame(width: 300)
//
//        }
    }
    
    @ViewBuilder
    internal func textEditorSection() -> some View {
        VStack {
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
    
    @ViewBuilder
    internal func getTabContent(selectedTab: Int) -> some View {
        switch selectedTab {
        case 0:
            if let uiImage = UIImage(data: vm.imageData[0]) {
                displayedImageLeft(uiImage)
            }
        case 1:
            if let uiImage = UIImage(data: vm.imageData[1]) {
                displayedImageRight(uiImage)
            }
        case 2:
            if let uiImage = UIImage(data: vm.imageData[2]) {
                displayedImageFront(uiImage)
            }
        default:
            Text("No images were found")
        }
    }
    
    internal func currentCanvasView(selectedTab: Int) -> PKCanvasView {
        switch selectedTab {
        case 0:
            return vm.canvasViewLeft
        case 1:
            return vm.canvasViewRight
        case 2:
            return vm.canvasViewFront
        default:
            return PKCanvasView() // fallback if needed
        }
    }
    
    func imageToLabelPicker(selectedTab: Binding<Int>) -> some View {
        HStack {
            Spacer()
            Text("Select an image to label:")
                .fontWeight(.semibold)
            Spacer()
            Picker("Select Image to Label", selection: selectedTab) {
                Text("Left").tag(0)
                Text("Right").tag(1)
                Text("Front").tag(2)
            }
            .pickerStyle(.menu)
            Spacer()
        }
        .padding(.vertical)
    }
    
    var savedTrackDataSheet: some View {
        ZStack {
//            Color.accentColor.ignoresSafeArea()
            Gradients.customGradientSheet.ignoresSafeArea()
                .overlay(.ultraThinMaterial)
            VStack {
                HStack {
                    Button {
                        vm.showSavedSheet = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                }
                 Spacer()
                }
                Spacer()
                Text("Your Progress was saved 😁")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
        }
    }
    
}

#Preview {
    LabelViewOld()
}
