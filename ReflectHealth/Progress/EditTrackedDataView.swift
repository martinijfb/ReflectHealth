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
    
    @State private var prediction: Double = 0
    @State var showSheet: Bool = false
    
    var acneType: String {
        switch prediction {
        case ..<1.9:
            return "Minimal or No Acne"
        case 1.9..<3.0:
            return "Mild Acne"
        case 3.0..<4.0:
            return "Moderate Acne"
        case 4.0..<5.0:
            return "Severe Acne"
        case 5.0:
            return "Very Severe Acne"
        default:
            return "Unknown Acne Type"
        }
    }
    
    var body: some View {
        
        VStack {
            Text(trackDataPiece.date.formatted(date: .long, time: .shortened))
                .font(.title2)
                .fontWeight(.light)
            
            ZStack {
                TopRoundedRectangle(cornerRadius: 48)
                    .fill(.lightBlue8)
                    .ignoresSafeArea()
                VStack {
                    
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
                            .fontWeight(.medium)
                            .padding(.top)
                        Spacer()
                    }
                    textEditorSection
                }
                .padding()
                .padding(.top)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back", systemImage: "chevron.backward") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                progressViewTitle
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Predict", systemImage: "face.dashed.fill") {
                    if let image3 =  UIImage(data: trackDataPiece.image3) {
                        uploadImage(image3)
                        showSheet = true
                    }
                }
            }
        }
        .tint(.lightBlue1)
        .sheet(isPresented: $showSheet, content: {
            predictionSheet
        })
        
        
    }
}

extension EditTrackedDataView {
    var predictionSheet: some View {
        ZStack {
            Gradients.customGradientSheet.ignoresSafeArea()
                .overlay(.ultraThinMaterial)
            VStack {
                HStack {
                    Button {
                        showSheet = false
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                Spacer()
                Group {
                    Spacer()
                    Text("Your acne score is:")
                    Text(String(format: "%.2f", prediction))
                        .fontWeight(.semibold)
                    
                }
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Group {
                    Text("Severity:")
                    Text(acneType)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
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
                .fontWeight(.light)
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
    
    internal var progressViewTitle: some View {
        Text("Your Progress")
            .toolbarTitleReflectStyle()
    }
    
    func uploadImage(_ image: UIImage) {
        guard let url = URL(string: "http://192.168.0.171:8000/predict/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 0.5)!
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n")
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([String: Double].self, from: data) {
                    DispatchQueue.main.async {
                        self.prediction = response["prediction"] ?? 10
                    }
                }
            }
        }.resume()
    }
    
}

#Preview {
    do {
        let previewer = try Previewer()
        return NavigationStack {EditTrackedDataView(trackDataPiece: previewer.trackDataPiece)
            .modelContainer(previewer.container)}
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
