//
//  ScannerView.swift
//  ReflectHealth
//
//  Created by Martin on 16/05/2024.
//

import SwiftUI
import RealityKit
import ARKit


struct ScannerView: View {
    
    @State var vm = ScannerViewModel()
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.width * (4 / 3)
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    if vm.imageData.count == 3 {
                        scanCompletedView
                            .onAppear {
                                vm.shouldPauseSession = true
                            }
                    } else {
                        ScannerViewRepresentable(vm: $vm)
                        
                        //                                        debuggingMatrix
                        scannerFrame
                        
                        VStack {
                            statusText
                            //                            Text("Images taken: \(vm.imageData.count)")
                            //                                .foregroundStyle(.yellow)
                            
                            Spacer()
                            calibrateButton
                        }
                    }
                    
                }
                .frame(width: width, height: height)
//                .border(vm.imageData.count == 3 ? Color.clear : Color.indigo, width: 2)
                
            }
            .onAppear {
                vm.shouldStartSession = true
                vm.deleteRecordedData()
            }
            .onDisappear {
                vm.shouldPauseSession = true
            }
            .navigationTitle("Face Scanner")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if vm.imageData.count == 3 {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            LabelView(vm: $vm)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        retakeScanButton
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            ScannerInstructionsView()
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    vm.didInitiallyCalibrate = false
                                    vm.shouldRestartSession = true
                                    if vm.imageData.count < 3 {
                                        vm.imageData.removeAll()
                                    }
                                }
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                        }
                    }
                }
            }
        }
    }
}


extension ScannerView {
    
    var scannerFrame: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2.0)
            .foregroundStyle(.white)
            .frame(width: width - (0.4 * width), height: height - (0.4 * height))
    }
    
    var statusText: some View {
        Text("\(vm.status)")
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
    }
    
    var calibrateButton: some View {
        Button(vm.didInitiallyCalibrate ? "Recalibrate" : "Calibrate") {
            vm.shouldRestartSession = true
            vm.imageData.removeAll()
            vm.didInitiallyCalibrate = true
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
    
    var retakeScanButton: some View {
        Button("Retake", systemImage: "arrow.uturn.backward.circle.fill") {
            vm.imageData.removeAll()
            vm.shouldStartSession = true
        }
    }
    
    @ViewBuilder
    var debuggingMatrix: some View {
        VStack {
            ForEach(0..<4, id: \.self) { row in
                HStack {
                    ForEach(0..<4, id: \.self) { column in
                        Text(String(format: "%.2f", vm.matrix[row, column]))
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
        VStack {
            Text("Your scan was completed")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .padding(.vertical)
            TabView {
                ForEach(vm.imageData, id: \.self) { data in
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
        .frame(width: width, height: height)
    }
    
}

#Preview {
    ScannerView()
}

#Preview {
    @State var scannerView = ScannerView()
    return scannerView.scanCompletedView
}
