//
//  LabelView+.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import SwiftUI
import PencilKit

extension LabelView {
    internal func displayedImageLeft(_ uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .overlay(
                textEditorInFocus ? nil :
                    GeometryReader { imageGeometry in
                        CanvasView(
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
                        CanvasView(
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
                        CanvasView(
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
            vm.shouldStartSession = true
            dismiss()
        } label: {
            Image(systemName: "trash")
        }
    }
    
    internal var saveRecordedDataButton: some View {
        Button("Save") {
            saveRecordedData()
        }
    }
    
    
    
    @ViewBuilder
    internal var textEditorSection: some View {
        VStack {
            HStack {
                TextField("Notes", text: $vm.textEditorText, axis: .vertical)
                    .focused($textEditorInFocus)
                    .padding()
                    .lineLimit(4)
                    .background(Color(uiColor: .systemGray6))
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
            Gradients.customGradientSheet.ignoresSafeArea()
                .overlay(.ultraThinMaterial)
            VStack {
                HStack {
                    Button {
                        vm.showSavedSheet = false
                        vm.shouldStartSession = true
                        dismiss()
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
    @State var vm = ScannerViewModel()
    return NavigationStack {
        LabelView(vm: $vm)
    }
}

#Preview {
    @State var vm = ScannerViewModel()
    let imageData: [Data] = [
                UIImage(named: "pikachu")!.pngData()!,
                UIImage(named: "charizard")!.pngData()!,
                UIImage(named: "rayquaza")!.pngData()!
    ]
    vm.imageData.append(contentsOf: imageData)
    return NavigationStack {
        LabelView(vm: $vm)
    }
}
