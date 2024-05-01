//
//  ScannerInstructionsView.swift
//  ReflectHealth
//
//  Created by Martin on 01/05/2024.
//

import SwiftUI

struct ScannerInstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var width = UIScreen.main.bounds.width
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("How to use our scanner?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        Text("Before starting your scan, **calibration** is essential to ensure accuracy and quality. Please follow these steps to calibrate the scanner properly:")
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("**Calibration Steps:**")
                                .fontWeight(.semibold)
                            Text("1. **Position Your Head:** Place your head within the view frame of the camera. The top of your forehead should align with the top of the frame, and your chin should align with the bottom of the frame.")
                            Text("2. **Start Calibration:** Press the 'Calibrate' button to begin. Ensure your head remains steady and within the frame during this process.")
                            Text("3. **Recalibration:** If the scanner fails to track movements or does not scan correctly when you turn your head, it may be necessary to recalibrate. To recalibrate, simply reposition your head within the frame and press the 'Recalibrate' button.")
                        }
                    }
                    
                    Group {
                        Text("**During the Scan:**")
                            .fontWeight(.semibold)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("- **Moving Your Head:** After calibration, you will be prompted to turn your head slowly to the left and right as instructed by the scanner.")
                            Text("- **Speed of Movement:** Move your head slowly and steadily. Quick movements can affect the scan's quality. Slow movements allow the scanner to capture more detailed information, resulting in a better quality scan.")
                        }
                    }
                    
                    Text("**Important:** Always ensure your head is correctly positioned within the frame throughout the scanning process. This consistency is crucial for a successful scan.")
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    
                    Text("Refer to the picture below to see how your head should be positioned within the frame. This visual guide will help you maintain the correct posture during both calibration and scanning phases.")
                    
                    // Placeholder for the head position image
                    HStack {
                        Spacer()
                        ZStack {
                            Image("person-outline")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.primary)
     
                            Image("scanner-frame")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.accent)
           
                        }
                        .frame(maxWidth: width - (width * 0.5))
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle("Instructions")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "chevron.backward") {
                        dismiss()
                    }
                }
            }
        }
}

#Preview {
    NavigationStack {
        ScannerInstructionsView()
    }
}
