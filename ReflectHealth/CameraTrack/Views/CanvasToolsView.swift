//
//  CanvasToolsView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct CanvasToolsView: View {
    
    @Binding var vm: LabelViewModel
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: vm.undo) {
                Image(systemName: "arrow.uturn.left")
                    .font(.title)
                    .foregroundColor(.green)
            }
            
            Button {
                vm.toolType = .pen
            } label: {
                Image(systemName: "pencil.and.outline")
                    .font(.title)
                    .foregroundStyle(vm.toolType == .pen ? vm.selectedColor : .gray.opacity(0.5))
            }
            
            Button {
                vm.toolType = .eraser
            } label: {
                Image(systemName: "eraser.line.dashed")
                    .font(.title)
                    .foregroundStyle(vm.toolType == .eraser ? .indigo : .gray.opacity(0.5))
            }
            
            ColorPicker("Color", selection: $vm.selectedColor, supportsOpacity: false)
                .labelsHidden()
                .disabled(vm.toolType == .eraser)
            
            Button(action: vm.clearCanvas) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}

#Preview {
    CanvasToolsView(vm: .constant(LabelViewModel())) // Use a constant binding
}
