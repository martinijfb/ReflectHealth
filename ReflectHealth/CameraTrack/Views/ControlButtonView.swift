//
//  ControlButtonView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct ControlButtonView: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }

    }
}

#Preview {
    ControlButtonView(label: "Cancel", action: {})
        .padding()
        .background(.black)
}
