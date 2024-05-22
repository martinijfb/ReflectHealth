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
                        ImageLabel(image: image1, drawingData: trackDataPiece.drawing1)
                        ImageLabel(image: image2, drawingData: trackDataPiece.drawing2)
                        ImageLabel(image: image3, drawingData: trackDataPiece.drawing3)
                    }
                    .frame(maxWidth: .infinity)
                    .tabViewStyle(.page)
                    
                } else {
                    Text("Could not load the images")
                }
                
                HStack {
                    Text("Edit you Notes:")
                        .fontWeight(.semibold)
                    .padding(.top)
                    Spacer()
                }
                textEditorSection
                
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

extension EditTrackedDataView {
    
    @ViewBuilder
    func ImageLabel(image: UIImage, drawingData: Data?) -> some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            if let safeData = drawingData {
                if let drawingImage = UIImage(data: safeData) {
                    Image(uiImage: drawingImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
        }
    }
    
    
    @ViewBuilder
    internal var textEditorSection: some View {
            HStack {
                TextField("Notes", text: $trackDataPiece.notes, axis: .vertical)
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

#Preview {
    do {
        let previewer = try Previewer()
        return EditTrackedDataView(trackDataPiece: previewer.trackDataPiece)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
