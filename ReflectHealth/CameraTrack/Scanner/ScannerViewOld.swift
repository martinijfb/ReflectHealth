//
//  ScannerView.swift
//  ReflectHealth
//
//  Created by Martin on 01/05/2024.
//

import SwiftUI
import RealityKit
import ARKit


struct ScannerViewOld: View {
    
    @State var status: String = "Please calibrate"
    @State var matrix = simd_float4x4()
    @State var shouldRestartSession: Bool = false
    @State var shouldPauseSession: Bool = false
    @State var shouldStartSession: Bool = false
    @State var didInitiallyCalibrate: Bool = false
    
    
    @Binding var imageData: [Data]
    @Binding var showScanner: Bool
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.width * (4 / 3)

    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ScannerViewModelOld(status: $status, matrix: $matrix, shouldRestartSession: $shouldRestartSession, shouldPauseSession: $shouldPauseSession, shouldStartSession: $shouldStartSession, imageData: $imageData, didInitiallyCalibrate: $didInitiallyCalibrate)
                    
//                    debuggingMatrix
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2.0)
                        .foregroundStyle(.white)
                        .frame(width: width - (0.4 * width), height: height - (0.4 * height))
                    
                    VStack {
                 
                            
                        Text("\(status)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                            .padding()
                        
//                        Text("Images taken: \(imageData.count)")
                        
                            
                     
                        Spacer()
                        Button(didInitiallyCalibrate ? "Recalibrate" : "Calibrate") {
                            shouldRestartSession = true
                            imageData.removeAll()
                            didInitiallyCalibrate = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    
            
                        if imageData.count == 3 {
                            scanCompletedView
                                .onAppear {
                                    shouldPauseSession = true
                                }
                        }
                    
                    

                    
                }
                .frame(width: width, height: height)
                .border(imageData.count == 3 ? Color.clear : Color.indigo, width: 2)
                
            }
            .navigationTitle("Face Scanner")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ScannerInstructionsView()
                            .navigationBarBackButtonHidden()
                            .onAppear {
                                didInitiallyCalibrate = false
                                shouldRestartSession = true
                                if imageData.count < 3 {
                                    imageData.removeAll()
                                }
                            }
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                    }

                }
                
                if imageData.count == 3 {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done", systemImage: "checkmark.circle.fill") {
                            showScanner = false
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Retake", systemImage: "arrow.uturn.backward.circle.fill") {
                            imageData.removeAll()
                            shouldStartSession = true
                        }
                    }
                } else {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel", systemImage: "xmark.circle.fill") {
                            imageData.removeAll()
                            didInitiallyCalibrate = false
                            showScanner = false
                        }
                    }
                    
                }
            
            }
            .preferredColorScheme(.dark)
            
        }
    }
}

extension ScannerViewOld {
    
    @ViewBuilder
    var debuggingMatrix: some View {
        VStack {
            ForEach(0..<4, id: \.self) { row in
                HStack {
                    ForEach(0..<4, id: \.self) { column in
                        Text(String(format: "%.2f", matrix[row, column]))
                            .frame(width: 50, height: 30)
                            .border(Color.black, width: 1)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
    
    @ViewBuilder
    var scanCompletedView: some View {
        ZStack {
            Rectangle()
                .fill(.black)
            VStack {
                Text("Your scan was completed")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                TabView {
                    ForEach(imageData, id: \.self) { data in
                        if let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                        }
                    }
                }
                .tabViewStyle(.page)
                .padding()
            }
        }
        .frame(width: width, height: height)
    }
    
}

#Preview {
    ScannerViewOld(imageData: .constant([
        UIImage(named: "pikachu")!.pngData()!,
        UIImage(named: "charizard")!.pngData()!,
        UIImage(named: "rayquaza")!.pngData()!,
    ]), showScanner: .constant(true))
}

#Preview {
    ScannerViewOld(imageData: .constant([Data]()), showScanner: .constant(true))
}
