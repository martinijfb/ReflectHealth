//
//  EditTrackedDataView.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import SwiftUI

struct EditTrackedDataView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var trackDataPiece: TrackedData
    @FocusState var textEditorInFocus
    // Correct with a textfield
    var body: some View {
        ZStack {
            Gradients.customGradient.ignoresSafeArea()
            VStack {
                Text("Your progress from:")
                    .fontWeight(.semibold)
                Text(trackDataPiece.date.formatted(date: .long, time: .shortened))
                if let image1 = UIImage(data: trackDataPiece.image1),
                   let image2 = UIImage(data: trackDataPiece.image2),
                   let image3 =  UIImage(data: trackDataPiece.image3) {
                    
                    TabView {
                        
                        
                        Group {
                            ZStack {
                                Image(uiImage: image1)
                                    .resizable()
                                if let drawingData1 = trackDataPiece.drawing1 {
                                    if let drawingImage1 = UIImage(data: drawingData1) {
                                        Image(uiImage: drawingImage1)
                                    }
                                }
                            }
                                
                            
                            ZStack {
                                Image(uiImage: image2)
                                    .resizable()
                                if let drawingData2 = trackDataPiece.drawing2 {
                                    if let drawingImage2 = UIImage(data: drawingData2) {
                                        Image(uiImage: drawingImage2)
                                    }
                                }
                            }
                                
                            
                            ZStack {
                                Image(uiImage: image3)
                                    .resizable()
                                if let drawingData3 = trackDataPiece.drawing3 {
                                    if let drawingImage3 = UIImage(data: drawingData3) {
                                        Image(uiImage: drawingImage3)
                                    }
                                }
                            }
                        }
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    .frame(maxHeight: 500)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    
                } else {
                    Text("Could not load the images")
                }
                
                HStack {
                    Text("Edit you Notes:")
                        .fontWeight(.semibold)
                    .padding(.top)
                    Spacer()
                }
                HStack {
                    TextEditor(text: $trackDataPiece.notes)
                        .focused($textEditorInFocus)
                        .foregroundStyle(.primary)
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
            .padding()
            .navigationTitle("Edit Data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "chevron.backward") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditTrackedDataView(trackDataPiece: previewer.trackDataPiece)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
