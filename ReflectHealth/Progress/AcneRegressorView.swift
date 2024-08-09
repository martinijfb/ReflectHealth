//
//  AcneRegressorView.swift
//  ReflectHealth
//
//  Created by Martin on 10/07/2024.
//

import SwiftUI

struct AcneRegressorView: View {
    @State var prediction: String = "no Prediction Now"
    @Binding var image: UIImage?
    let urlStringIPPort: String =  "http://192.168.0.171:8000/predict/"
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Unable to find an image")
                    .foregroundColor(.gray)
            }
            Text(prediction)
                .padding()
            
            Button(action: {
                if let image = image {
                    uploadImage(image)
                }
            }) {
                Text("Predict")
            }
        }
        .padding()
    }
}


extension AcneRegressorView {
    
    func uploadImage(_ image: UIImage) {
        guard let url = URL(string: urlStringIPPort) else { return }
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
                        self.prediction = "Prediction: \(response["prediction"]!)"
                    }
                }
            }
        }.resume()
    }
    
}


//#Preview {
//    AcneRegressorView(image: )
//}
